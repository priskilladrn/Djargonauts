//
//  PlayAloneQuestionView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import SwiftUI

struct PlayAloneQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    @State var isCorrect = [0,0,0,0,0,0,0,0,0,0]
    @State var score: Int = 0
    @State var i = 0
    @State private var timeRemaining = 15
    @State var randomWord: String = ""
    @State var randomInt: Int = 0
    var playAloneVM: PlayAloneViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var questions: [Jargon]
    @State var isFlipped = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                
                VStack {
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
                    //MARK: flash card view
                    PlayAloneCardView(base: questions[i].base ?? "", wrongAnswer: randomWord, category: questions[i].category ?? "", desc: questions[i].desc ?? "", cardCount: 10, currentCard: i+1, randomInt: randomInt, score: $score, i: $i, isCorrect: $isCorrect, isFlipped: $isFlipped, playAloneVM: playAloneVM)
//                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.65)
//                    Button("test"){
//                        print("12345 masuk")
//                    }
//                    Spacer()
                    
//                    ScrollView(.horizontal) {
//                        HStack (spacing: 20) {
//                            ForEach(0..<10) { i in
//                                switch (isCorrect[i]) {
//                                case -1:
//                                    ZStack {
//                                        Circle()
//                                            .frame(width: geo.size.width * 0.1)
//                                            .foregroundColor(AppColor.red)
//                                        Image(systemName: "xmark")
//                                            .fontWeight(.black)
//                                            .foregroundColor(.white)
//                                    }
//                                case 1:
//                                    ZStack {
//                                        Circle()
//                                            .frame(width: geo.size.width * 0.1)
//                                            .foregroundColor(AppColor.green)
//                                        
//                                        Image(systemName: "checkmark")
//                                            .fontWeight(.black)
//                                            .foregroundColor(.white)
//                                    }
//                                default:
//                                    Circle()
//                                        .frame(width: geo.size.width * 0.1)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                        }
//                        .padding(.leading, geo.size.width * 0.05)
//                    }
                    
                    if timeRemaining > 0 {
                        Text("\(timeRemaining)")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(AppColor.title)
                    } else {
                        if i < 9 {
                            BorderedButtonView(text: "Next"){
                                i += 1
                                timeRemaining = 15
                                isFlipped = false
                            }
//                            Button {
//
//                            } label: {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill()
//                                        .foregroundColor(AppColor.secondary)
//                                        .shadow(color: .black, radius: 4)
//                                        .overlay(content: {
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color(.white), lineWidth: 3)
//                                        })
//                                    Text("Next")
//                                        .font(.system(size: 20, weight: .semibold))
//                                        .foregroundColor(Color(hex: 001477))
//                                }
//                            }
//                            .padding(.top, geo.size.height * 0.05)
                        } else {
                            BorderedButtonLinkView(text: "Next", destination:  AnyView(ScoreSoloView(score: score)))
//                            NavigationLink{
//
//                            } label: {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill()
//                                        .foregroundColor(AppColor.secondary)
//                                        .shadow(color: .black, radius: 4)
//                                        .overlay(content: {
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color(.white), lineWidth: 3)
//                                        })
//                                    Text("Next")
//                                        .font(.system(size: 20, weight: .semibold))
//                                        .foregroundColor(Color(hex: 001477))
//                                }
//                            }
//                            .padding(.top, geo.size.height * 0.05)
                        }
                    }
                    
//                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .onReceive(timer) { time in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining == 0 && isCorrect[i] == 0 {
                    isCorrect[i] = -1
                    
                    isFlipped = true
                }
            }
            .onAppear {
//                jargonListVM.searchCategory(category: questions[0].category!)
                randomWord = (jargonListVM.jargonList.randomElement()!.base)!
                randomInt = Int.random(in: 1..<3)
            }
        }
    }
}

//struct PlayAloneQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayAloneQuestionView(category: "Tech", questions: [])
//    }
//}
