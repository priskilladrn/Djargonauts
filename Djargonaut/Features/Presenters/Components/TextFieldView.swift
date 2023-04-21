//
//  TextFieldView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var body: some View {
        TextField("", text: $text)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Title"), lineWidth: 2)
            )
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant(""))
    }
}
