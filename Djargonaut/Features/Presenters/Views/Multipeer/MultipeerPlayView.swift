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
    fileprivate func nextQuestionFromGuesser() {
        multipeerSession.send(data: GameMessage(type: GameMessageType.triggerNext))
        
        // guesser become explainer
        vm.currentStage = .explain
        withAnimation{
            currentQuestionIndex += 1
        }
        
        isFlipped = false
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "star.fill")
                Text("\(score)")
                Spacer()
                
                Image(systemName: "house.fill")
            }
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
                        
                        score += 50
                    }, wrongAnswerAction: {
                        isAnswerCorrect = false
                        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: false))
                        vm.currentStage = .revealResultGuesser
                        
                        isFlipped = true
                    })
                }
            Spacer()
            if vm.currentStage == .revealResultGuesser {
                if isAnswerCorrect {
                    Text("jawaban bener!")
                    Button("Next"){
                        nextQuestionFromGuesser()
                    }
                } else {
                    Text("jawaban salah!")
                    HStack{
                        Button("Penjelasan bener"){
                            
                            multipeerSession.send(data: GameMessage(type: GameMessageType.isExplanationCorrect))
                            
                            nextQuestionFromGuesser()
                        }
                        Button("Penjelasan salah"){
                            nextQuestionFromGuesser()
                            
                        }
                    }
                }
            } else if vm.currentStage == .revealResultExplainer {
                if multipeerSession.receivedData?.isAnswerCorrect == true {
                    Text("tebakan guesser bener")
                } else {
                    Text("tebakan guesser salah")
                }            }
            Text("[time]")
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
            } else if receivedData?.type == GameMessageType.isExplanationCorrect {
                score += 50
            }
        }
        .padding(.horizontal, 16)
        .onChange(of: currentQuestionIndex){ index in
            if index >= vm.roomSetting.words.count {
                redirectToScore = true
            }
        }
        .navigationDestination(isPresented: $redirectToScore) {
            ScoreMultipeerView()
        }
    }
}

//struct MultipeerPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipeerPlayView()
//    }
//}
