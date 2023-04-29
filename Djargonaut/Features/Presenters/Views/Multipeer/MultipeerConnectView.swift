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
    @ObservedObject var multipeerViewModel: MultipeerViewModel
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
            VStack {
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
                
                Button("liat setting"){
                    print("\(multipeerViewModel.roomSetting.chosenCategory)")
                    print("\(multipeerViewModel.roomSetting.duration)")
                    do{
                        let string = try String(data: GameMessage(type: 0, roomSetting: multipeerViewModel.roomSetting).encode(), encoding: .utf8) ?? "ERR"
                        print(string)
                        
                    } catch {
                        print("error")
                    }
                }
            }
        } else {
            Text("masuk, udah paired sama \(opponentName)")
                .onAppear{
                    if isRoomCreator {
                        multipeerSession.send(data: GameMessage(type: 0, roomSetting: multipeerViewModel.roomSetting))
                    }
                }
                .alert("masuk: ", isPresented: $multipeerSession.hasReceivedData){

                }
//
            ButtonView(text: "coba"){
                do {
                    var cat: String = multipeerSession.receivedData!.roomSetting!.chosenCategory
                    var dur: Int = multipeerSession.receivedData!.roomSetting!.duration
                    
                    print("category: \(cat), duration: \(dur)")
                } catch {
                    
                }
            }
        }
    }
}

//struct MultipeerConnectView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipeerConnectView(multipeerSession: MultipeerSession(nickname: "test123"), multipeerViewModel: multipeerViewModel)
//    }
//}
