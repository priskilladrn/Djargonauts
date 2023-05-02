//
//  MultipeerViewModel.swift
//  Djargonaut
//
//  Created by Jevon Levin on 21/04/23.
//

import Foundation
enum Stage{
    case pregame, explain, guess, revealResultExplainer, revealResultGuesser, final
}
class MultipeerViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var roomSetting: RoomSetting = RoomSetting()
    @Published var currentStage: Stage = .pregame
}
