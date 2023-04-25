//
//  DjargonautApp.swift
//  Djargonaut
//
//  Created by Jevon Levin on 18/04/23.
//

import SwiftUI

@main
struct DjargonautApp: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.container.viewContext
            
            ContentView()
                .environmentObject(JargonListViewModel(context: viewContext))
        }
    }
}
