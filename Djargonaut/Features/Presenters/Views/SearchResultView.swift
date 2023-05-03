//
//  SearchResultView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 18/04/23.
//

import SwiftUI


struct SearchResultView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    var body: some View {
        JargonListView()
        Text("ola")
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        SearchResultView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
