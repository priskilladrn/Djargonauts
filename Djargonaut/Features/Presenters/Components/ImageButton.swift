//
//  ImageButton.swift
//  Djargonaut
//
//  Created by Jevon Levin on 24/04/23.
//

import SwiftUI

struct ImageButtonLink: View {
    var text: String
    var imageName: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                Text(text)
                    .textCase(.uppercase)
                    .foregroundColor(Color("Default"))
            }
            .frame(width: 118.55)
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonLink(text: "asdf", imageName: "home_solo"){
            
        }
    }
}
