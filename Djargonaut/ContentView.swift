//
//  ContentView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            // TODO: belom ada homepage, test ini dulu ya hehe
            MultipeerInitView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
