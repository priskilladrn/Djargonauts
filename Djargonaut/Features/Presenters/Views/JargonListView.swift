//
//  JargonsItemView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 02/05/23.
//

import SwiftUI

struct JargonListView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    let sections = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @State private var base: String = ""

    
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
    
    var searchBar: some View {
        HStack {
            Image(systemName:"magnifyingglass")
                .foregroundColor(Color("Title"))
            TextField("Search", text: $base)
                .opacity(2)
                .foregroundColor(Color("Title"))
            Spacer()
        }
        .padding(10)
        .cornerRadius(23)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("Title"), lineWidth: 2)
        )
    }
    
    var body: some View {
        List {
            ForEach(sections.filter{ self.searchForSection($0) }, id: \.self) { section in
                Section(header: Text("\(section)")) {
                    ForEach(jargonListVM.jargonList.filter { section == String($0.base!.prefix(1)).uppercased() && self.searchForJargon($0.base!) }) { jargon in
                        NavigationLink(destination: DictionaryView(base: jargon.base ?? "unknown", category: jargon.category ?? "unknown", desc: jargon.desc ?? "unknown").toolbarRole(.editor)) {
                            VStack (alignment: .leading) {
                                Text(jargon.base ?? "unknown")
                                    .font(.headline)
                                Text(jargon.category ?? "unknown")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                }
            }
        }
        .listStyle(PlainListStyle())

        .scrollContentBackground(.hidden)
        .onAppear(perform: {
            jargonListVM.populate()
        })
        .navigationTitle("Title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    searchBar
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.bottom, 20)
        .frame(maxHeight: .infinity)
    }
    
    private func searchForSection(_ txt: String) -> Bool {
        return (txt.prefix(1).lowercased(with: .current).hasPrefix(base.prefix(1).lowercased(with: .current)))
    }
    
    private func searchForJargon(_ txt: String) -> Bool {
        return (txt.lowercased(with: .current).hasPrefix(base.lowercased(with: .current)))
    }
}

struct JargonListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        JargonListView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
