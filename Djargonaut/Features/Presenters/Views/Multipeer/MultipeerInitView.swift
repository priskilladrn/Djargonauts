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
                .foregroundColor(AppColor.title)
                .bold()
            
            // TODO: validate nickname must be filled
            TextFieldView(text: $multipeerViewModel.nickname)
            
            Spacer()
            
            ButtonLinkView(text: "Create Room", destination: MultipeerCreateView(multipeerViewModel: multipeerViewModel))
            ButtonLinkView(text: "Join Room", isPrimary: false, destination: MultipeerConnectView(multipeerSession: MultipeerSession(nickname: multipeerViewModel.nickname), multipeerViewModel: multipeerViewModel))
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
