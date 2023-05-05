//
//  ContentView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    init() {
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.left")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
    }
    
    var body: some View {
        NavigationStack{
            HomeView()
                
        }
        .tint(AppColor.title)
        .onAppear {
            jargonListVM.deleteAll()
            jargonListVM.populate()
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
