//
//  GameCardView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 03/05/23.
//

import SwiftUI

//struct ExplainerFrontView: View {
//    
//}

struct MultipeerCardView: View {
    let base: String
    let category: String
    let desc: String
    let cardCount: Int
    let currentCard: Int
    
    var body: some View {
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
                    .padding(.vertical, 15)
                Spacer()
                Divider()
                    .overlay(.white)
                    .padding(.vertical, 15)
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

struct MultipeerCardView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerCardView(base: "Deprecate", category: "Technology", desc: "In several fields, especially computing, deprecation is the discouragement of use of some terminology, feature, design, or practice, typically because it has been superseded or is no longer considered efficient or safe, without completely removing it or prohibiting its use. ", cardCount: 10, currentCard: 1)
    }
}
