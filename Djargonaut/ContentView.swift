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
    @State private var jargons = [Jargon]()
    
    init(vm: JargonListViewModel) {
        self.JargonListVM = vm
    }
    
    var body: some View {
        NavigationStack{
            HomeView()
        }
        .onAppear(perform: {
            jargons = JargonListVM.populate()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        ContentView(vm: JargonListViewModel(context: viewContext))
    }
}
