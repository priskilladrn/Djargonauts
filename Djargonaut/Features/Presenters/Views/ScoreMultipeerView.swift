//
//  ScoreView.swift
//  Djargonaut
//
//  Created by Belinda Angelica on 27/04/23.
//

import SwiftUI

struct ScoreMultipeerView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Multiplayer")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                        .font(.system(size: 18))
                    Divider()
                        .frame(width: 120, height: 2)
                        .background(Color("Title"))
                    Text("Technology")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                        .font(.system(size: 18))
                    Image("Score_Multipeer")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.08)
                }
                
                VStack {
                    Text("You Win!")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .font(.system(size: 45))
                        .offset(y:-135)
                    HStack {
                        Image(systemName: "star.fill")
                            .offset(y:-90)
                            .foregroundColor(Color("Title"))
                        Text("Score")
                            .foregroundColor(Color("Title"))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .offset(y:-90)
                        Image(systemName: "star.fill")
                            .offset(y:-90)
                            .foregroundColor(Color("Title"))
                    }
                    Text("8000")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                        .offset(y:-85)
                    Text("Nice Try!")
                        .foregroundColor(Color("Title"))
                        .padding(.top, 20)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .offset(y:-100)
                        
                }
                
                VStack {
                    Spacer()
                        .frame(height: geo.size.height * 0.8)

                    Button {
                        
                    } label: {
                        BorderedButtonView(text: "Exit to Main Menu", destination: HomeView())
                    }
                .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
                }
                .padding(.bottom)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    struct ScoreMultipeerView_Previews: PreviewProvider {
        static var previews: some View {
            ScoreMultipeerView()
        }
    }
}
