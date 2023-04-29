//
//  MultipeerViewModel.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import Foundation

class MultipeerViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var roomSetting: RoomSetting = RoomSetting()
    
}
