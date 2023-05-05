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
            VStack {
                if multipeerSession.availablePeers.isEmpty {
                    Spacer()
                    Text("Searching for other players...")
                    Spacer()
                } else {
                    List(multipeerSession.availablePeers, id: \.self) { peer in
                        Button(peer.displayName) {
                            opponentName = peer.displayName
                            multipeerSession.serviceBrowser.invitePeer(peer, to: multipeerSession.session, withContext: nil, timeout: 30)
                        }
                    }
                    .background(Image("background").resizable()
                        .aspectRatio( contentMode: .fill))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Game Room")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColor.title)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background").resizable()
                .aspectRatio( contentMode: .fill))
            
        } else if !multipeerSession.hasPaired && isRoomCreator {
            VStack {
                Spacer()
                Text("Waiting for other player to join...")
                    .alert("\(multipeerSession.invitationSender?.displayName ?? "ERR") wants to join your room!", isPresented: $multipeerSession.hasReceivedInvite) {
                        Button("Reject") {
                            if (multipeerSession.invitationHandler != nil) {
                                multipeerSession.invitationHandler!(false, nil)
                                
                            }
                        }
                        Button("Accept") {
                            if (multipeerSession.invitationHandler != nil) {
                                multipeerSession.invitationHandler!(true, multipeerSession.session)
                                opponentName = multipeerSession.invitationSender?.displayName ?? "ERR"
                                
                            }
                        }
                }
             
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Game Room")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColor.title)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background").resizable()
                .aspectRatio( contentMode: .fill))
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
