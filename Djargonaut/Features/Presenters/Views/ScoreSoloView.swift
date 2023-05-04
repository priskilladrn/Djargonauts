//
//  ScoreSoloView.swift
//  Djargonaut
//
//  Created by Belinda Angelica on 30/04/23.
//

import SwiftUI

struct ScoreSoloView: View {
    let score: Int
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.32)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .offset(y:50)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.1)
                                .foregroundColor(AppColor.secondary)
                                .shadow(radius: 5)
                                .offset(y:-235)
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(.white), lineWidth: 4)
                                .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.1)
                                .offset(y:-235)
                        }
                    }
                    VStack {
                        Text("Nice Job!")
                            .foregroundColor(Color("ScoreColor"))
                            .fontWeight(.bold)
                            .font(.system(size: 45))
                            .offset(y:-55)
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("Secondary"))
                            Text("Score")
                                .foregroundColor(Color("ScoreColor"))
                                .fontWeight(.medium)
                                .font(.system(size: 30))
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("Secondary"))
                        }
                        Text("\(score)")
                            .foregroundColor(Color("ScoreColor"))
                            .fontWeight(.bold)
                            .font(.system(size: 60))
                    }
                }
                .padding(38)
                Spacer()
                Button {
                    NavigationUtil.popToRootView()
                } label: {
<<<<<<< HEAD
                    BorderedButtonView(text: "Exit to Main Menu", destination: EmptyView())
=======
                    BorderedButtonLinkView(text: "Exit to Main Menu", destination: HomeView())
>>>>>>> 4b541eed9dd2f8f2bbf734d589fd01918613d35e
                }
                .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
            }
            .navigationBarBackButtonHidden(true)
        }
        .padding(.bottom)
        
        .background(
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image("Score_Solo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .ignoresSafeArea()
                        .offset(x: -25, y: UIScreen.main.bounds.height / 14 - 50)
                }
                .padding(.bottom, 70)
            }
        )
    }
    
    struct ScoreSoloView_Previews: PreviewProvider {
        static var previews: some View {
            ScoreSoloView(score: 800)
        }
    }
}
