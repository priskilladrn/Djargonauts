//
//  MultipeerInitView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import SwiftUI

struct MultipeerInitView: View {
    @State var nicknameTxt: String = ""
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Nickname")
                .textCase(.uppercase)
                .foregroundColor(Color("Title"))
                .bold()
            TextFieldView(text: $nicknameTxt)
            
            Spacer()
            
            ButtonLinkView(text: "Create Room", destination: MultipeerCreateView())
            ButtonLinkView(text: "Join Room", isPrimary: false, destination: MultipeerJoinView())
        }
        .padding()
        .navigationTitle("Play Together")
    }
}

struct MultipeerInitView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerInitView()
    }
}
