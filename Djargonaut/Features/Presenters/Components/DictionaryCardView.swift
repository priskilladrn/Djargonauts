//
//  CardView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 02/05/23.
//

import SwiftUI

struct DictionaryCardView: View {
    let base: String
    let category: String
    let desc: String
    
    var body: some View {
        HStack (alignment: .top) {
            VStack(alignment: .leading) {
                Text("\(category)")
                    .foregroundColor(.white)
                    .font(.system(size: 21))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.white), lineWidth: 1.5)
                    )
                Spacer()
                Text("\(base)")
                    .font(.system(size: 41, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                Spacer()
                Divider()
                    .overlay(.white)
                    .padding(.vertical, 15)
                Spacer()
                Text("\(desc)")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
            }
        }
        .frame(maxWidth: 332, maxHeight: 452)
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


struct DictionaryCardView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryCardView(base: "Deprecate", category: "Design", desc: "In several fields, especially computing, deprecation ")
    }
}
