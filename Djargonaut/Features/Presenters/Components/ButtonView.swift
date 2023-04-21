//
//  ButtonView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import SwiftUI

struct ButtonView: View {
    var text: String
    var isPrimary: Bool = true
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(text)
                .textCase(.uppercase)
                .bold()
                .foregroundColor(isPrimary ? .white : Color("Title"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(isPrimary ? Color(
                    "Title") : Color("Secondary"))
                .cornerRadius(12)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "create room"){
            
        }
    }
}
