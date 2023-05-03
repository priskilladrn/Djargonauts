//
//  JargonsItemView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 02/05/23.
//

import SwiftUI

struct JargonListView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    //    //MARK: vars
    //    let jargonModel: JargonModel
    //
    //    //MARK: init
    //    init(jargonModel: JargonModel) {
    //        self.jargonModel = jargonModel
    //    }
    
    //    @FetchRequest(entity: Jargon.entity(), sortDescriptors: [
    //            NSSortDescriptor(keyPath: \Jargon.base, ascending: true)
    //        ]) var jargons: FetchedResults<Jargon>
    //
    //    //MARK: body
    
    //    let random = jargonListVM.jargonList.randomElement()!
    var body: some View {
            List {
                ForEach(jargonListVM.jargonList) { jargon in
                    Text(jargon.base ?? " ")
                    //                    NavigationLink(destination: CardView(base: jargon.base ?? "unknown", category: jargon.category ?? "unknown", desc: jargon.desc ?? "unknown")) {
                    //                        Text(jargon.base ?? "unknown")
                    //                        Text("halo")
                    //                    }
                }
            }
            .ignoresSafeArea()
            .scrollContentBackground(.hidden)
        .onAppear(perform: {
            jargonListVM.populate()
        })
    }
}

struct JargonListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        JargonListView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
