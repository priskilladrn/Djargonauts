//
//  MultipeerPlayView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 29/04/23.
//

import SwiftUI
import MGFlipView


struct MultipeerPlayView: View {
    @ObservedObject var multipeerSession: MultipeerSession
    @ObservedObject var vm: MultipeerViewModel
    
    @State private var currentQuestionIndex = 0
    @State private var isAnswerCorrect = false
    @State private var redirectToScore = false
    
    @State private var isFlipped = false
    
    @State private var frontView: AnyView?
    @State private var backView: AnyView?
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "star")
                Text("[score]")
            }
            Spacer()
            
            //            VStack{
            //                if currentQuestionIndex >= vm.roomSetting.words.count {
            //                    ScoreMultipeerView()
            //
            //                } else
            FlipView(frontView: {VStack{
                if vm.currentStage == .explain || vm.currentStage == .revealResultExplainer {
                    HStack{
                        Text("[Category]")
                        Spacer()
                        Text("1 / [total]")
                    }
                    Text("soal: \(vm.roomSetting.words[currentQuestionIndex].base)")
                    Divider()
                    Text("[Description]")
                } else if vm.currentStage == .guess || vm.currentStage == .revealResultGuesser {
                    Text("Jawabannya:")
                    Button("\(vm.roomSetting.words[currentQuestionIndex].base)"){
                        isAnswerCorrect = true
                        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: true))
                        vm.currentStage = .revealResultGuesser
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isFlipped = true
                        }
                    }
                    Button("[ini opsi yang salah]"){
                        isAnswerCorrect = false
                        multipeerSession.send(data: GameMessage(type: GameMessageType.answer, isAnswerCorrect: false))
                        vm.currentStage = .revealResultGuesser
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isFlipped = true
                        }
                    }
                }
                
            }.frame(width: 500, height: 500).border(.red)}, backView: {VStack{
                if vm.currentStage == .explain || vm.currentStage == .guess {
                    Text("Loading")
                }
                else if vm.currentStage == .revealResultGuesser {
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isFlipped = false
                        }
                    }
                } else if vm.currentStage == .revealResultExplainer  {
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isFlipped = false
                        }
                    }
                }
                
                
            }.frame(width: 500, height: 500).border(.red)}, flipped: $isFlipped, flipAxis: .y, animation: .init(type: .linear, duration: 0.5))
            .onChange(of: multipeerSession.receivedData){ receivedData in
                if receivedData?.type == GameMessageType.answer && vm.currentStage == .explain {
                    vm.currentStage = .revealResultExplainer
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isFlipped = true
                    }
                } else if receivedData?.type == GameMessageType.triggerNext {
                    currentQuestionIndex += 1
                    vm.currentStage = vm.currentStage == .revealResultGuesser ? .explain : .guess
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isFlipped = false
                    }
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
