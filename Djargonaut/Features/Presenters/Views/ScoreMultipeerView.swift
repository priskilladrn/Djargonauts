//
//  ScoreView.swift
//  Djargonaut
//
//  Created by Belinda Angelica on 27/04/23.
//

import SwiftUI

struct ScoreMultipeerView: View {
    @Binding var score: Int
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
                        Text("Winner")
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
                    BorderedButtonLinkView(text: "Exit to Main Menu", destination: HomeView())
                    .padding(.horizontal, 32)
//                .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
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
                    Image("Score_Multipeer")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .frame(width: 400, height: 400)
                }
                .padding(.bottom, 60)
            }
        )
    }
//    struct ScoreMultipeerView_Previews: PreviewProvider {
//        static var previews: some View {
//            ScoreMultipeerView()
//        }
//    }
}
