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
    var isRoomCreator: Bool = false
    var logger = Logger()
        
    var body: some View {
        if !multipeerSession.paired && !isRoomCreator {
            HStack {
                List(multipeerSession.availablePeers, id: \.self) { peer in
                    Button(peer.displayName) {
                        multipeerSession.serviceBrowser.invitePeer(peer, to: multipeerSession.session, withContext: nil, timeout: 30)
                    }
                }
            }
            
        } else if !multipeerSession.paired && isRoomCreator {
            Text("tunggu ada yang join")
                .alert("Received an invite from \(multipeerSession.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $multipeerSession.recvdInvite) {
                    Button("Accept invite") {
                        if (multipeerSession.invitationHandler != nil) {
                            multipeerSession.invitationHandler!(true, multipeerSession.session)
                        }
                    }
                    Button("Reject invite") {
                        if (multipeerSession.invitationHandler != nil) {
                            multipeerSession.invitationHandler!(false, nil)
                        }
                    }
                }
        } else {
            Text("masuk, udah paired")
//            GameView(rpsSession: rpsSession)
        }
    }
}

struct MultipeerConnectView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerConnectView(multipeerSession: MultipeerSession(nickname: "test123"))
    }
}
