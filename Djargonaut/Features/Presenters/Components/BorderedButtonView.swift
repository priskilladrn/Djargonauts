//
//  BorderedButtonView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 30/04/23.
//

import SwiftUI

struct BorderedButtonView: View {
    var text: String
    var fillColor: Color
    var strokeColor: Color
    var textColor: Color
    var height: CGFloat
    var width: CGFloat
    var destination: any View
    
    var body: some View {
        NavigationLink {
            AnyView(destination)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill()
                    .foregroundColor(fillColor)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(strokeColor, lineWidth: 3)
                    })
                Text(text)
                    .foregroundColor(textColor)
                    .fontWeight(.semibold)
            }
        }
        .frame(width: width, height: height)
    }
}

struct BorderedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BorderedButtonView(text: "Randomize", fillColor: AppColor.secondary, strokeColor: AppColor.title, textColor: Color(hex: 001477), height: 50, width: 320, destination: EmptyView())
    }
}
