//
//  SliderView.swift
//  Djargonaut
//
//  Created by Wita Dewisari Tasya on 20/04/23.
//

import SwiftUI

struct SliderView: View {
    let bubbleChat = ["Hi, Djargonauts! I'm Jarjar!", "Oh, you want to play with your friend? Sure!"]
    let helpHeading = ["Solo Guide", "Multi Player Guide"]
    let items = ["I'll accompany you in learning jargon via Solo Mode. Pick one category you want to learn or let me choose it for you. On the card, choose one jargon that fits the explanation. I will give you stars for every correct answer!", "Get closer to your friend so we can know you're playing with them. After you choose Multiplayer Mode, choose your nickname and create a room. You can set the room with your preferences. Let your friend join the room and we'll start the game. I will give you a role, either an explainer or a guesser. As an explainer, you need to explain the word given to the guesser. The guesser needs to choose the correct jargon based on the explanation. I'll give you stars if you explain or answer it right. Collect as many stars as you can to win the game!"]
    
    var body: some View {
        VStack{
            TabView{
                ForEach (0..<2) { i in
                    VStack{
                        Text("\(helpHeading[i])").font(.headline)
                            .padding()
                            .foregroundColor(AppColor.purpleDark)
                        HStack{
                            Image("astronot_talk")
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill()
                                    .foregroundColor(Color.white)
                                    .shadow(color: .black, radius: 4)
                                    .frame(height: 70)
                                Text("\(bubbleChat[i])")
                                    .padding()
                                    .foregroundColor(AppColor.purple)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        Text("\(items[i])")
                            .padding()
                            .foregroundColor(AppColor.purple)
                    }
                }
            }.tabViewStyle(PageTabViewStyle())
            
        }.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
