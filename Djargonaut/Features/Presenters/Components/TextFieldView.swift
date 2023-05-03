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
            .onChange(of: text) { newValue in
                if newValue.count > 15 {
                    self.text = String(newValue.prefix(15))
                }
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColor.title, lineWidth: 2)
            )
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant(""))
    }
}
