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
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
    }
    
    var body: some View {
        NavigationStack{
            HomeView()
                .background(Image("background").resizable()
                    .aspectRatio( contentMode: .fill))
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
