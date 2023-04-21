//
//  MultipeerConnectView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import SwiftUI
import os
struct MultipeerConnectView: View {
    @StateObject var multipeerSession: MultipeerSession
    
    @State var opponentName: String = ""
    
    var isRoomCreator: Bool = false
    var logger = Logger()
        
    var body: some View {
        if !multipeerSession.hasPaired && !isRoomCreator {
            HStack {
                List(multipeerSession.availablePeers, id: \.self) { peer in
                    Button(peer.displayName) {
                        opponentName = peer.displayName
                        multipeerSession.serviceBrowser.invitePeer(peer, to: multipeerSession.session, withContext: nil, timeout: 30)
                    }
                }
            }
            
        } else if !multipeerSession.hasPaired && isRoomCreator {
            Text("tunggu ada yang join")
                .alert("Received an invite from \(multipeerSession.invitationSender?.displayName ?? "ERR")!", isPresented: $multipeerSession.hasReceivedInvite) {
                    Button("Accept invite") {
                        if (multipeerSession.invitationHandler != nil) {
                            multipeerSession.invitationHandler!(true, multipeerSession.session)
                            opponentName = multipeerSession.invitationSender?.displayName ?? "ERR"
                        }
                    }
                    Button("Reject invite") {
                        if (multipeerSession.invitationHandler != nil) {
                            multipeerSession.invitationHandler!(false, nil)
                            
                        }
                    }
                }
        } else {
            Text("masuk, udah paired sama \(opponentName)")
//                .alert("masuk: \(multipeerSession.receivedData)", isPresented: $multipeerSession.hasReceivedData){
//
//                }
//
//            ButtonView(text: "coba"){
//                multipeerSession.send(data: "halo, \(opponentName)")
//            }
        }
    }
}

struct MultipeerConnectView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerConnectView(multipeerSession: MultipeerSession(nickname: "test123"))
    }
}
