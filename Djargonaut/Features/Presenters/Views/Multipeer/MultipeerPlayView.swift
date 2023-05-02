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
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "star")
                Text("[score]")
            }
            Spacer()
            
            VStack{
                //                if currentQuestionIndex >= vm.roomSetting.words.count {
                //                    ScoreMultipeerView()
                //
                //                } else
                if vm.roomSetting.words.isEmpty || currentQuestionIndex >= vm.roomSetting.words.count {
                    Text("Loading")
                } else if vm.currentStage == .explain {
                    HStack{
                        Text("[Category]")
                        Spacer()
                        Text("1 / [total]")
                    }
                    Text("soal: \(vm.roomSetting.words[currentQuestionIndex].base)")
                    Divider()
                    Text("[Description]")
                } else if vm.currentStage == .guess {
                    Text("Jawabannya:")
                    Button("\(vm.roomSetting.words[currentQuestionIndex].base)"){
                        isAnswerCorrect = true
                        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: true))
                        vm.currentStage = .revealResultGuesser
                    }
                    Button("[ini opsi yang salah]"){
                        isAnswerCorrect = false
                        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: false))
                        vm.currentStage = .revealResultGuesser
                    }
                } else if vm.currentStage == .revealResultGuesser {
                    if isAnswerCorrect {
                        Text("jawaban bener!")
                    } else {
                        Text("jawaban salah!")
                    }
                    Button("Next"){
                        multipeerSession.send(data: GameMessage(type: GameMessageType.triggerNext))
                        
                        currentQuestionIndex += 1
                        // guesser become explainer
                        vm.currentStage = .explain
                    }
                } else if vm.currentStage == .revealResultExplainer {
                    if multipeerSession.receivedData?.isAnswerCorrect == true {
                        Text("tebakan guesser bener")
                    } else {
                        Text("tebakan guesser salah")
                    }
                    Button("Next"){
                        multipeerSession.send(data: GameMessage(type: GameMessageType.triggerNext))
                        
                        currentQuestionIndex += 1
                        // explainer become guesser
                        vm.currentStage = .guess
                    }
                }
            }
            .padding(.vertical)
            .border(AppColor.purpleDark)
            .onChange(of: multipeerSession.receivedData){ receivedData in
                if receivedData?.type == GameMessageType.answer && vm.currentStage == .explain {
                    vm.currentStage = .revealResultExplainer
                } else if receivedData?.type == GameMessageType.triggerNext {
                    currentQuestionIndex += 1
                    vm.currentStage = vm.currentStage == .revealResultGuesser ? .explain : .guess
                }
            }
            
            Spacer()
            
            Text("[time]")
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
