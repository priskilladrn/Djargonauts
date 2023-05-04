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
    @State private var errorMsg = ""
    @State private var navigateToCreateView = false
    @State private var navigateToConnectView = false
    var body: some View {
        VStack{
            Spacer()
            
            Text("Nickname")
                .textCase(.uppercase)
                .foregroundColor(AppColor.title)
                .bold()
            
            // TODO: validate nickname must be filled
            TextFieldView(text: $multipeerViewModel.nickname)
            Text(errorMsg)
                .foregroundColor(.red)
            Spacer()
            
            BorderedButtonView(text: "Create Room", isPrimary: true){
                if (isNicknameValid(multipeerViewModel.nickname)) {
                    navigateToCreateView = true
                }
            }
            .padding(.bottom, 16)
            BorderedButtonView(text: "Join Room"){
                if (isNicknameValid(multipeerViewModel.nickname)) {
                    navigateToConnectView = true
                }
            }
        }
        .padding()
        .navigationTitle("Play Together")
        .navigationDestination(isPresented: $navigateToCreateView){
            MultipeerCreateView(multipeerViewModel: multipeerViewModel)
        }.navigationDestination(isPresented: $navigateToConnectView){
            MultipeerConnectView(multipeerSession: MultipeerSession(nickname: multipeerViewModel.nickname), vm: multipeerViewModel)
        }
        .background(Image("background").resizable()
            .aspectRatio( contentMode: .fill))
    }
    
    func isNicknameValid (_ nickname: String) -> Bool {
        if nickname.isEmpty {
            errorMsg = "Nickname must be filled!"
            return false
        }
        errorMsg = ""
        return true
    }
}

struct MultipeerInitView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerInitView()
    }
}
