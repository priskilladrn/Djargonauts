//
//  MultipeerPlayView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 29/04/23.
//

import SwiftUI



struct MultipeerPlayView: View {
    @ObservedObject var multipeerSession: MultipeerSession
    @ObservedObject var vm: MultipeerViewModel
    
    @State private var currentQuestionIndex = 0
    @State private var isAnswerCorrect = false
    @State private var redirectToScore = false
    
    @State var isFlipped = false
    
    @State var score = 0
    
    @State private var timeRemaining: Int = 3
    
    @State private var isWin: Bool = false
    
    let globalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private func nextQuestionFromGuesser() {
        multipeerSession.send(data: GameMessage(type: GameMessageType.triggerNext))
        
        // guesser become explainer
        vm.currentStage = .explain
        withAnimation{
            currentQuestionIndex += 1
        }
        
        isFlipped = false
        
        timeRemaining = vm.roomSetting.duration
    }
    
    fileprivate func sendWrongAnswerToExplainer() {
        isAnswerCorrect = false
        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: false))
        vm.currentStage = .revealResultGuesser
        
        isFlipped = true
    }
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(AppColor.title)
                Text("\(score)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(AppColor.title)
                
                Spacer()
                
                Button {
                    NavigationUtil.popToRootView()
                } label: {
                    Image(systemName: "house.fill")
                        .foregroundColor(AppColor.title)
                }
            }
            .foregroundColor(AppColor.title)
            Spacer()
            
//            VStack{
                //                if currentQuestionIndex >= vm.roomSetting.words.count {
                //                    ScoreMultipeerView()
                //
                //                } else
                if vm.roomSetting.words.isEmpty || currentQuestionIndex >= vm.roomSetting.words.count {
                    Text("Loading")
                } else if vm.currentStage == .explain || vm.currentStage == .revealResultExplainer {
                    var currentJargon = vm.roomSetting.words[currentQuestionIndex]
                    MultipeerExplainerCardView(base: currentJargon.base, category: currentJargon.category, desc: currentJargon.desc, cardCount: vm.roomSetting.cardCount, currentCard: currentQuestionIndex + 1, isFlipped: $isFlipped)
                } else if vm.currentStage == .guess || vm.currentStage == .revealResultGuesser {
                    var currentJargon = vm.roomSetting.words[currentQuestionIndex]
                    MultipeerGuesserCardView(base: currentJargon.base, category: currentJargon.category, desc: currentJargon.desc, cardCount: vm.roomSetting.cardCount, currentCard: currentQuestionIndex + 1, isFlipped: $isFlipped, correctAnswerAction: {
                        isAnswerCorrect = true
                        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: true))
                        vm.currentStage = .revealResultGuesser
                        
                        isFlipped = true
                        
                        score += 25
                    }, wrongAnswerAction: {
                        sendWrongAnswerToExplainer()
                    })
                }
            Spacer()
            if vm.currentStage == .revealResultGuesser {
                if isAnswerCorrect {
                    Text("Your answer is correct!")
                    BorderedButtonView(text: "Next"){
                        nextQuestionFromGuesser()
                    }
                } else {
                    Text("Your answer is incorrect! How’s your partner’s explanation before?")
                    HStack{
                        BorderedButtonView(text: "Unclear"){
                            nextQuestionFromGuesser()
                            
                        }
                        Spacer()
                        BorderedButtonView(text: "Well Explained", isPrimary: true){
                            
                            multipeerSession.send(data: GameMessage(type: GameMessageType.isExplanationCorrect))
                            
                            nextQuestionFromGuesser()
                        }
                    }
                }
            } else if vm.currentStage == .revealResultExplainer {
//                if multipeerSession.receivedData?.isAnswerCorrect == true {
//                    Text("tebakan guesser bener")
//                } else {
//                    Text("tebakan guesser salah")
//                }
                Text("Waiting confirmation your partner…")
            }
            
            if vm.currentStage == .explain || vm.currentStage == .guess{
                Text("\(timeRemaining)")
            }
        }
        .onChange(of: multipeerSession.receivedData){ receivedData in
            if receivedData?.type == GameMessageType.answer && vm.currentStage == .explain {
                vm.currentStage = .revealResultExplainer
                isFlipped = true
                
                if receivedData?.isAnswerCorrect == true {
                    score += 100
                }
            } else if receivedData?.type == GameMessageType.triggerNext {
                vm.currentStage = vm.currentStage == .revealResultGuesser ? .explain : .guess
                withAnimation{
                    currentQuestionIndex += 1
                }
                
                isFlipped = false
                
                timeRemaining = vm.roomSetting.duration
            } else if receivedData?.type == GameMessageType.isExplanationCorrect {
                score += 25
            } else if receivedData?.type == GameMessageType.opponentFinalScore {
                isWin = score > (receivedData?.opponentFinalScore ?? 0)
                redirectToScore = true
            }
        }
        .padding(.horizontal, 16)
        .onChange(of: currentQuestionIndex){ index in
            if index >= vm.roomSetting.words.count {
                multipeerSession.send(data: GameMessage(type: GameMessageType.opponentFinalScore, opponentFinalScore: score))
            }
        }
        .navigationDestination(isPresented: $redirectToScore) {
            ScoreMultipeerView(score: $score, isWin: $isWin)
        }
        .onAppear{
            timeRemaining = vm.roomSetting.duration
        }
        .onReceive(globalTimer){ time in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }else {
                // next
                if vm.currentStage == .guess {
                    sendWrongAnswerToExplainer()
                }
            }
        }
        .background(Image("background").resizable()
            .aspectRatio( contentMode: .fill))
    }
}

//struct MultipeerPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipeerPlayView()
//    }
//}
