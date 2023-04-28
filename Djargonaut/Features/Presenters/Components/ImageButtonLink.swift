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
    var destination: any View
    var body: some View {
        NavigationLink{
            AnyView(destination)
        } label: {
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                Text(text)
                    .foregroundColor(AppColor.def)
            }
            .frame(width: 118.55)
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonLink(text: "asdf", imageName: "home_solo", destination: EmptyView())
    }
}
