//
//  PlayAlonePickCategoryView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 25/04/23.
//

import SwiftUI

struct PlayAlonePickCategoryView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(jargonListVM.jargonList) { jargon in
                    Text(jargon.base ?? "Not Found")
                }
            }
        }
        .onAppear(perform: {
            jargonListVM.searchWord(word: "Array")
        })
    }
}

struct PlayAlonePickCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        PlayAlonePickCategoryView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
