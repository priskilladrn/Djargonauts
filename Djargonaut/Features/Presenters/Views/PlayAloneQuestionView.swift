//
//  PlayAloneQuestionView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import SwiftUI

struct PlayAloneQuestionView: View {
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
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(AppColor.title)
                            .frame(height: geo.size.height * 0.03)
                        Text("\(score)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(AppColor.title)

                        Spacer()

                        Button {
                            NavigationUtil.popToRootView()
                        } label: {
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(AppColor.title)
                                .frame(height: geo.size.height * 0.03)
                        }
                    }
                    .foregroundColor(AppColor.title)
                    .padding(.horizontal, geo.size.width * 0.05)
                    
                    //MARK: flash card view
                    PlayAloneCardView(base: questions[i].base ?? "", wrongAnswer: randomWord, category: questions[i].category ?? "", desc: questions[i].desc ?? "", cardCount: 10, currentCard: i+1, randomInt: randomInt, width: geo.size.width * 0.05, score: $score, i: $i, isCorrect: $isCorrect, isFlipped: $isFlipped, timeRemaining: $timeRemaining, playAloneVM: playAloneVM)
                    
                    ScrollView(.horizontal) {
                        HStack (spacing: 20) {
                            ForEach(0..<10) { i in
                                switch (isCorrect[i]) {
                                case -1:
                                    ZStack {
                                        Circle()
                                            .frame(width: geo.size.width * 0.1)
                                            .foregroundColor(AppColor.red)
                                        Image(systemName: "xmark")
                                            .fontWeight(.black)
                                            .foregroundColor(.white)
                                    }
                                case 1:
                                    ZStack {
                                        Circle()
                                            .frame(width: geo.size.width * 0.1)
                                            .foregroundColor(AppColor.green)
                                        
                                        Image(systemName: "checkmark")
                                            .fontWeight(.black)
                                            .foregroundColor(.white)
                                    }
                                default:
                                    Circle()
                                        .frame(width: geo.size.width * 0.1)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.leading, geo.size.width * 0.05)
                    }
                    .scrollIndicators(.hidden)
                    
                    if timeRemaining > 0 {
                        Text("\(timeRemaining)")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(AppColor.title)
                    } else {
                        if i < 9 {
                            Button {
                                isFlipped = false
                                timeRemaining = 15
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    i += 1
                                    randomWord = (jargonListVM.jargonList.randomElement()!.base)!
                                    randomInt = Int.random(in: 1..<3)
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill()
                                        .foregroundColor(AppColor.secondary)
                                        .shadow(color: .black, radius: 4)
                                        .overlay(content: {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(.white), lineWidth: 3)
                                        })
                                    Text("Next")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Color(hex: 001477))
                                }
                            }
                            .frame(width: geo.size.width * 0.5 ,height: geo.size.height * 0.06)
                            .padding(.top, geo.size.height * 0.05)
                        } else {
                            NavigationLink{
                                AnyView(ScoreSoloView(score: score))
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill()
                                        .foregroundColor(AppColor.secondary)
                                        .shadow(color: .black, radius: 4)
                                        .overlay(content: {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(.white), lineWidth: 3)
                                        })
                                    Text("Next")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Color(hex: 001477))
                                }
                            }
                            .frame(width: geo.size.width * 0.5 ,height: geo.size.height * 0.06)
                            .padding(.top, geo.size.height * 0.05)
                        }
                    }
                    
                    Spacer()
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
                jargonListVM.searchCategory(category: questions[0].category!)
                randomWord = (jargonListVM.jargonList.randomElement()!.base)!
                randomInt = Int.random(in: 1..<3)
            }
        }
    }
    
    func selectBorder() -> Color {
            var border: Color = Color("Border_Tech")
            if (questions[i].category  == "Technology") {
                border = Color("Border_Tech")
            } else if (questions[i].category == "Design") {
                border = Color("Border_Design")
            } else if (questions[i].category == "Accounting") {
                border = Color("Border_Accounting")
            } else if (questions[i].category == "Game") {
                border = Color("Border_Game")
            }
            return border
        }
        
}

//struct PlayAloneQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayAloneQuestionView(category: "Tech", questions: [])
//    }
//}
