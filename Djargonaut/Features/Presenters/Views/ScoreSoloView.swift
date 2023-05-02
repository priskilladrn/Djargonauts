//
//  ScoreSoloView.swift
//  Djargonaut
//
//  Created by Belinda Angelica on 30/04/23.
//

import SwiftUI

struct ScoreSoloView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Solo Mode")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                        .font(.system(size: 18))
                    Divider()
                        .frame(width: 120)
                        .frame(width: 120, height: 2)
                        .background(Color("Title"))
                    Text("Technology")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                        .font(.system(size: 18))
                    Image("Score_Solo")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .offset(x: -25, y: UIScreen.main.bounds.height / 2.38 - 50)
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.6)
                }
                
                VStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("Title"))
                        Text("Score")
                            .foregroundColor(Color("Title"))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("Title"))
                    }
                    Text("8000")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                    Text("Nice Try!")
                        .foregroundColor(Color("Title"))
                        .padding(.top, 20)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    Spacer()
                        .frame(height: geo.size.height * 0.5)

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
}

struct ScoreSoloView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSoloView()
    }
}
