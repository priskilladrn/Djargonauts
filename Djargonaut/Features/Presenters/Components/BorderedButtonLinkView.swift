//
//  BorderedButtonView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import SwiftUI

private struct BorderedButtonTemplateView: View {
    var text: String
    var isPrimary: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill()
                .foregroundColor(isPrimary ? AppColor.scoreColor : AppColor.secondary)
                .shadow(color: .black, radius: 4)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(.white), lineWidth: 3)
                })
            Text(text)
                .foregroundColor(isPrimary ? .white : AppColor.scoreColor)
                .fontWeight(.semibold)
        }
        .frame(height: 52)
    }
}

struct BorderedButtonLinkView: View {
    var text: String
    var isPrimary: Bool = false
    var destination: any View
    var body: some View {
        NavigationLink {
            AnyView(destination)
        } label: {
            BorderedButtonTemplateView(text: text, isPrimary: isPrimary)
        }
    }
}

struct BorderedButtonView: View {
    var text: String
    var isPrimary: Bool = false
    var action: () -> Void
    var body: some View {
        Button (action: action) {
            BorderedButtonTemplateView(text: text, isPrimary: isPrimary)
        }
    }
}

//struct BorderedButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        BorderedButtonView()
//    }
//}
