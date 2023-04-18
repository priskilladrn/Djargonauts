//
//  SearchPage.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 18/04/23.
//

import SwiftUI

struct SearchPageView: View {
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
            
            HStack {
                Image(systemName:"magnifyingglass")
                    .foregroundColor(Color("Title"))
                Text("Search")
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
        .padding(.bottom, 20)
        .padding(.horizontal, 25)
        .frame(maxHeight: .infinity)
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
