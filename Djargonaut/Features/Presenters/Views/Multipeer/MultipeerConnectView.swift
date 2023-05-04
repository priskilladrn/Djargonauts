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
    @ObservedObject var vm: MultipeerViewModel
    @State var opponentName: String = ""
    
    var isRoomCreator: Bool = false
    var logger = Logger()
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
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
                    print("\(vm.roomSetting.chosenCategory)")
                    print("\(vm.roomSetting.duration)")
                    print("\(jargonListVM.jargonList.filter{ $0.category == vm.roomSetting.chosenCategory}.shuffled().prefix(vm.roomSetting.cardCount).map{ JargonModel(from: $0) })")
                    do{
                        let string = try String(data: GameMessage(type: GameMessageType.roomSetting, roomSetting: vm.roomSetting).encode(), encoding: .utf8) ?? "ERR"
                        print(string)
                        
                    } catch {
                        print("error")
                    }
                }
            }
        } else {
            MultipeerPlayView(multipeerSession: multipeerSession, vm: vm)
                .onAppear{
                    if isRoomCreator {
                        vm.roomSetting.words = jargonListVM.jargonList.filter{ $0.category == vm.roomSetting.chosenCategory}.shuffled().prefix(vm.roomSetting.cardCount).map{ JargonModel(from: $0) }
                        vm.currentStage = .explain
                        multipeerSession.send(data: GameMessage(type: GameMessageType.roomSetting, roomSetting: vm.roomSetting))
                    }
                }
                .onChange(of: multipeerSession.receivedData){ receivedData in
                    if !isRoomCreator && receivedData != nil && vm.currentStage == .pregame {
                        vm.currentStage = .guess
                        vm.roomSetting = receivedData!.roomSetting!
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
