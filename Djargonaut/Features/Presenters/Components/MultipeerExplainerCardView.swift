//
//  ContentView.swift
//  Belajar
//
//  Created by Wita Dewisari Tasya on 20/04/23.
//

import SwiftUI

struct MultipeerExplainerCardView: View {
    //MARK: Variables
    let base: String
    let category: String
    let desc: String
    let cardCount: Int
    let currentCard: Int
    
    @Binding var isFlipped: Bool
    
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    
    
    //MARK: Flip Card Function
    func flipCard () {
//        isFlipped = !isFlipped
        if !isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    //MARK: View Body
    var body: some View {
        VStack{
            ZStack {
                ExplainerSideCard(base: base, category: category, desc: "Explain this to your partner!", cardCount: cardCount, currentCard: currentCard, degree: $frontDegree)
                ExplainerSideCard(base: base, category: category, desc: desc, cardCount: cardCount, currentCard: currentCard, degree: $backDegree)
            }
//            .onTapGesture {
//                flipCard ()
//            }
            .padding()
        }
        .onChange(of: isFlipped){ _ in
            flipCard()
        }
        
        
    }
}

struct ExplainerSideCard : View {
    let base: String
    let category: String
    let desc: String
    let cardCount: Int
    let currentCard: Int
    
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            HStack (alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(category)")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.white), lineWidth: 1.5)
                            )
                        Spacer()
                        Text("\(currentCard) / \(cardCount)")
                            .foregroundColor(.white)
                            .font(.system(size: 23, weight: .bold))
                    }
                    Spacer()
                    Text("\(base)")
                        .font(.system(size: 43, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Divider()
                        .overlay(.white)
                    Spacer()
                    Text("\(desc)")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                        .frame(minHeight: 30, alignment: .top)
                    
                    Spacer()
                    
                }
            }
            .frame(width: 332, height: 452)
            .padding(40)
            .background(
                Image("\(selectBackground())")
                    .resizable()
                    .scaledToFit()
            )
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
    }
    
    func selectBackground() -> String {
        var bg: String = ""
        if (category == "Technology") {
            bg = "Flashcards_Tech"
        } else if (category == "Design") {
            bg = "Flashcards_Design"
        } else if (category == "Accounting") {
            bg = "Flashcards_Accounting"
        } else if (category == "Game") {
            bg = "Flashcards_Game"
        }
        return bg
    }
}

//struct MultipeerExplainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        MultipeerExplainerCardView(base: "Deprecate Intelligence", category: "Technology", desc: "The theory and development of computer systems able to perform tasks that normally require human intelligence, such as visual perception, speech recognition, decision-making, and translation between languages. Ipsum", cardCount: 10, currentCard: 1)
//    }
//}
