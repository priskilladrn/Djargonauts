//
//  ContentView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            HomeView()
                .background(Image("background").resizable()
                    .aspectRatio( contentMode: .fill))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        ContentView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
