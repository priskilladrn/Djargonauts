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
            VStack {
                HomeView()
            }
        }
//        .onAppear(perform: {
//            jargonListVM.populate()
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        ContentView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
