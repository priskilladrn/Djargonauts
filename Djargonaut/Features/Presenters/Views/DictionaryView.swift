//
//  DictionaryView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 04/05/23.
//

import SwiftUI

struct DictionaryView: View {
    let base: String
    let category: String
    let desc: String
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            HStack {
                Spacer()
                DictionaryCardView(base: base , category: category , desc: desc )
                Spacer()
            }
            .frame(maxWidth: 370, maxHeight: 490)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("\(category)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColor.title)
            }
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView(base: "Deprecate", category: "Design", desc: "In several fields, especially computing, deprecation ")
    }
}
