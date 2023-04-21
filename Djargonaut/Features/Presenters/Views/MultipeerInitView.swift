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
            
            ButtonView(text: "Create Room"){
                
            }
            ButtonView(text: "Join Room", isPrimary: false){
                
            }
        }
        .padding()
    }
}

struct MultipeerInitView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerInitView()
    }
}
