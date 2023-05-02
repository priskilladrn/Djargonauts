//
//  CustomBackButton.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var text: String
    
    var body: some View {
        GeometryReader { geo in
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(AppColor.title)
                        .frame(width: geo.size.width * 0.05)
                        .padding(.leading, geo.size.width * 0.05)
                        .padding(.trailing, geo.size.width * 0.02)
                    Text(text)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(AppColor.title)
                    Spacer()
                }
            }
        }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton(text: "Pick a Category")
    }
}
