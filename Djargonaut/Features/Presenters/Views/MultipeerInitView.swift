//
//  MultipeerInitView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import SwiftUI

struct MultipeerInitView: View {
//    @State var nicknameTxt: String = ""
    @StateObject var multipeerViewModel = MultipeerViewModel()
    var body: some View {
        VStack{
            Spacer()
            
            Text("Nickname")
                .textCase(.uppercase)
                .foregroundColor(Color("Title"))
                .bold()
            TextFieldView(text: $multipeerViewModel.nickname)
            
            Spacer()
            
            ButtonLinkView(text: "Create Room", destination: MultipeerCreateView(multipeerViewModel: multipeerViewModel))
            ButtonLinkView(text: "Join Room", isPrimary: false, destination: MultipeerConnectView(multipeerSession: MultipeerSession(nickname: multipeerViewModel.nickname)))
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
