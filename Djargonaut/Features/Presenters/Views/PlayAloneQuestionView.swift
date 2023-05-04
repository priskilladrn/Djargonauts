//
//  PlayAloneQuestionView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import SwiftUI

struct PlayAloneQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var isCorrect = [0,1,-1,0,0,0,0,0,0,0]
    @State var score: Int = 0
    @State var i = 0
    @State private var timeRemaining = 15
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var questions: [Jargon]
    
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
//                    Text("category: \(questions[i].base ?? "")")
                    
                    
                    Spacer()
                    
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
                    
                    if timeRemaining > 0 {
                        Text("\(timeRemaining)")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(AppColor.title)
                    } else {
                        if i < 9 {
                            Button {
                                i += 1
                                timeRemaining = 15
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
                }
            }
        }
    }
}

//struct PlayAloneQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayAloneQuestionView(category: "Tech", questions: [])
//    }
//}
