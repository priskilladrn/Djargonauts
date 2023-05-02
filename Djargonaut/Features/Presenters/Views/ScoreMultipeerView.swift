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
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Multiplayer")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                    Divider()
                        .frame(width: 120)
                        .background(Color("Title"))
                    Text("Technology")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                    Image("Score_Multipeer")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .aspectRatio(contentMode: .fit)
                        .offset(y: UIScreen.main.bounds.height / 16 - 50)
                    
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
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill()
                                .foregroundColor(AppColor.secondary)
                                .shadow(color: .black, radius: 4)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.white, lineWidth: 3)
                                })
                            
                            Text("Exit to Main Menu")
                                .foregroundColor(Color("Title"))
                                .fontWeight(.bold)
                        }
                    }
                .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
                }
                .padding(.bottom)
            }
        }
    }
    struct ScoreMultipeerView_Previews: PreviewProvider {
        static var previews: some View {
            ScoreMultipeerView()
        }
    }
}
