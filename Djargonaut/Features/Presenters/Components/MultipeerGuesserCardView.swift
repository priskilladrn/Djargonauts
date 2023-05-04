//
//  MultipeerGuesserCardView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 04/05/23.
//

import SwiftUI

struct MultipeerGuesserCardView: View {
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
    var correctAnswerAction: () -> Void
    var wrongAnswerAction: () -> Void
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
                GuesserFront(base: base, category: category, desc: desc, cardCount: cardCount, currentCard: currentCard, degree: $frontDegree, correctAnswerAction: correctAnswerAction, wrongAnswerAction: wrongAnswerAction)
                GuesserBack(base: base, category: category, desc: desc, cardCount: cardCount, currentCard: currentCard, degree: $backDegree)
            }.onTapGesture {
                flipCard ()
            }
            .padding()
        }
        .onChange(of: isFlipped){ _ in
            flipCard()
        }
        
    }
}

struct GuesserFront : View {
    let base: String
    let category: String
    let desc: String
    let cardCount: Int
    let currentCard: Int
    
    @Binding var degree : Double
    
    var correctAnswerAction: () -> Void
    var wrongAnswerAction: () -> Void
    
    var body: some View {
        ZStack {
            HStack (alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("\(currentCard) / \(cardCount)")
                            .foregroundColor(.white)
                            .font(.system(size: 23, weight: .bold))
                    }
                    Spacer()
                    Text("Listen to your partner & choose an answer")
                        .font(.system(size: 26, weight: .bold))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    
                    //MARK: Answer 1
                    Button(action: correctAnswerAction) {
                        
                        Text(base)
                            .foregroundColor(.white)
                            .font(.system(size:18, weight: .bold))
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(AppColor.purple)
                            .cornerRadius(13)
                    }
                    Divider()
                        .overlay(.white)
                        .padding(.vertical, 20)
                    
                    //MARK: Answer 2
                    Button(action: wrongAnswerAction) {
                        
                        Text("[opsi salah]")
                            .foregroundColor(.white)
                            .font(.system(size:18, weight: .bold))
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(AppColor.purple)
                            .cornerRadius(13)
                    }
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

struct GuesserBack : View {
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

//struct MultipeerGuesserCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipeerGuesserCardView(base: "Deprecate", category: "Technology", desc: "Lorem Ipsum", cardCount: 10, currentCard: 1)
//    }
//}
