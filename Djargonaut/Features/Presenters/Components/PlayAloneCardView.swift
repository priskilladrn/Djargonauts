//
//  MultipeerGuesserCardView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 04/05/23.
//

import SwiftUI

struct PlayAloneCardView: View {
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    //MARK: Variables
    let base: String
    let wrongAnswer: String
    let category: String
    let desc: String
    let cardCount: Int
    let currentCard: Int
    let randomInt: Int
    
    @State var timeTime: Int = 1
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    
    @Binding var score: Int
    @Binding var i: Int
    @Binding var isCorrect: [Int]
    @Binding var isFlipped: Bool
    
    let durationAndDelay : CGFloat = 0.1
    let playAloneVM: PlayAloneViewModel
    
    //MARK: Flip Card Function
    func flipCard () {
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
                CardFront(base: base, category: category, desc: desc, wrongAnswer: wrongAnswer, cardCount: cardCount, currentCard: currentCard, playAloneVM: playAloneVM, randomInt: randomInt, isCorrect: $isCorrect, degree: $frontDegree, score: $score, i: $i, isFlipped: $isFlipped)
                CardBack(base: base, category: category, desc: desc, cardCount: cardCount, currentCard: currentCard, degree: $backDegree)
            }
            .padding()
        }
        .onChange(of: isFlipped){ _ in
            flipCard()
        }
    }
}

struct CardFront : View {
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    let base: String
    let category: String
    let desc: String
    let wrongAnswer: String
    let cardCount: Int
    let currentCard: Int
    let playAloneVM: PlayAloneViewModel
    let randomInt: Int
    
    @State var options = Array<String>()

    @Binding var isCorrect: [Int]
    @Binding var degree : Double
    @Binding var score: Int
    @Binding var i: Int
    @Binding var isFlipped: Bool
    
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
                    Text("\(desc)")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                    Spacer()
                    
                    Divider()
                        .overlay(.white)
                        .padding(.vertical, 20)
                 
                    
                    if randomInt == 1 {
                        //MARK: Answer 1
                        Button {
                            print("pencet")
                            isCorrect[i] = 1
                            score += 100
                            i += 1
                            isFlipped = true
                        } label: {
                            Text("\(base)")
                                .foregroundColor(.white)
                                .font(.system(size:18, weight: .bold))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(AppColor.purple)
                                .cornerRadius(13)
                                .padding(.vertical, 20)
                        }

                        //MARK: Answer 2
                        Button {
                            print("pencet")
                            isCorrect[i] = -1
                            i += 1
                            isFlipped = true
                        } label: {
                            Text("\(wrongAnswer)")
                                .foregroundColor(.white)
                                .font(.system(size:18, weight: .bold))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(AppColor.purple)
                                .cornerRadius(13)
                        }
                        Spacer()
                    } else {
                        //MARK: Answer 1
                        Button {
                            print("pencet")
                            isCorrect[i] = -1
                            i += 1
                            isFlipped = true
                        } label: {
                            Text("\(wrongAnswer)")
                                .foregroundColor(.white)
                                .font(.system(size:18, weight: .bold))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(AppColor.purple)
                                .cornerRadius(13)
                                .padding(.vertical, 20)
                        }

                        //MARK: Answer 2
                        Button {
                            print("pencet")
                            isCorrect[i] = 1
                            score += 100
                            i += 1
                            isFlipped = true
                        } label: {
                            Text("\(base)")
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
            }
            .frame(height: 452)
            .padding(40)
            .background(
                Image("\(selectBackground())")
                    .resizable()
                    .scaledToFit()
            )
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
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

struct CardBack : View {
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
//            .frame(width: 332, height: 452)
            .frame(height: 452)
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

//struct PlayAloneCardView_Preview: PreviewProvider {
//    static var previews: some View {
//        let viewContext = CoreDataManager.shared.container.viewContext
//        
//        PlayAloneCardView(base: "Artificial Intelligence", wrongAnswer: "AI", category: "Technology", desc: "Lorem Ipsum", cardCount: 10, currentCard: 1, playAloneVM: PlayAloneViewModel())
//            .environmentObject(JargonListViewModel(context: viewContext))
//    }
//}
