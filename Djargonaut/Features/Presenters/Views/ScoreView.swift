//
//  ScoreView.swift
//  Djargonaut
//
//  Created by Belinda Angelica on 27/04/23.
//

import SwiftUI

struct ScoreView: View {
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
                        .fontWeight(.semibold)
                        .kerning(1)
                    Divider()
                        .frame(width: 120)
                        .background(Color.black)
                    Text("Technology")
                        .fontWeight(.bold)
                        .kerning(1)
                    Image("Score_Multipeer")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .aspectRatio(contentMode: .fit)
                        .offset(y: UIScreen.main.bounds.height / 18 - 50)
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.07)
                }
                
                VStack {
                    Text("You Win!")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 45))
                        .offset(y:-100)
                    Text("Score")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .offset(y:-60)
                    Text("8000")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                        .offset(y:-60)
                    Text("Nice Try!")
                        .padding(.top, 20)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .offset(y:-50)
                }
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill()
                            .foregroundColor(AppColor.secondary)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(AppColor.title, lineWidth: 3)
                            })
                        Text("Randomize")
                            .foregroundColor(Color("Title"))
                    }
                }
                .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
                
                Spacer()
            }
        }
    }
    struct ScoreView_Previews: PreviewProvider {
        static var previews: some View {
            ScoreView()
        }
    }
}
