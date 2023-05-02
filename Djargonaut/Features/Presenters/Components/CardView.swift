//
//  CardView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 02/05/23.
//

import SwiftUI

struct CardView: View {
    let base: String
    let category: String
    let desc: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(category)")
                .foregroundColor(.white)
                .font(.system(size: 23))
                .padding(.vertical, 3)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.white), lineWidth: 1.5)
                )
            
            Text("\(base)")
                .font(.system(size: 43, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical, 50)
            
            Divider()
                .overlay(.white)
                .padding(.vertical, 30)
            
            Text("\(desc)")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
        }
        .padding(40)
        .background(
            ZStack (alignment: .top){
                Image("Flashcards_Tech")
                    .resizable()
                    .scaledToFill()
            }
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(base: "Deprecate", category: "Technology", desc: "In several fields, especially computing, deprecation is the discouragement of use of some terminology, feature, design, or practice, typically because it has been superseded or is no longer considered efficient or safe, without completely removing it or prohibiting its use. ")
    }
}
