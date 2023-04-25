//
//  ContentView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    private var JargonListVM: JargonListViewModel
    var jargons: [Jargon]
    
    init(vm: JargonListViewModel) {
        self.JargonListVM = vm
        jargons = JargonListVM.populate()
    }
    
    var body: some View {
        NavigationStack{
            HomeView(jargons: jargons)
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
