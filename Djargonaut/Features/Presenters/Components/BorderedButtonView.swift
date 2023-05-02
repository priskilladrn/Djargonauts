//
//  BorderedButtonView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import SwiftUI

struct BorderedButtonView: View {
    var text: String
    var destination: any View
    
    var body: some View {
        NavigationLink {
            AnyView(destination)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill()
                    .foregroundColor(AppColor.secondary)
                    .shadow(color: .black, radius: 4)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(.white), lineWidth: 3)
                    })
                Text(text)
                    .foregroundColor(Color(hex: 001477))
                    .fontWeight(.semibold)
            }
        }
    }
}

//struct BorderedButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        BorderedButtonView()
//    }
//}
