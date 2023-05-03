//
//  SearchPage.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 18/04/23.
//

import SwiftUI

struct SearchPageView: View {
    
    @State private var searchText: String = ""
    
    var searchBar: some View {
        HStack {
            Image(systemName:"magnifyingglass")
                .foregroundColor(Color("Title"))
            TextField("Search", text: $searchText)
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
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .foregroundColor(Color("Title"))
                    .fontWeight(.bold)
                Text("Search Jargon")
                    .foregroundColor(Color("Title"))
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            
            searchBar
            
            SearchResultView()
            
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 25)
        .frame(maxHeight: .infinity)
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        SearchPageView().environmentObject(JargonListViewModel(context: viewContext))
    }
}
