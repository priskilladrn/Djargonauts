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
//    @Binding var isActive: Bool
    
    var body: some View {
        NavigationLink(
        destination: AnyView(destination)
        ){
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColor.title)
            }
            .frame(width: 132)
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonLink(text: "asdf", imageName: "home_solo", destination: EmptyView())
    }
}
