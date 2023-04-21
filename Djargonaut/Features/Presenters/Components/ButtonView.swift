//
//  ButtonView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import SwiftUI

private struct ButtonContent: View {
    var text: String
    var isPrimary: Bool = true
    var body: some View {
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

struct ButtonView: View {
    var text: String
    var isPrimary: Bool = true
    var action: () -> Void
    var body: some View {
        Button(action: action){
            ButtonContent(text: text, isPrimary: isPrimary)
        }
    }
}

struct ButtonLinkView: View {
    var text: String
    var isPrimary: Bool = true
    var destination: any View
    var body: some View {
        NavigationLink{
            AnyView(destination)
        } label: {
            ButtonContent(text: text, isPrimary: isPrimary)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "create room"){
            
        }
    }
}
