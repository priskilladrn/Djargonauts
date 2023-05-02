//
//  RandomView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 30/04/23.
//

import SwiftUI

struct RandomView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            Text("Randomizing")
                .fontWeight(.bold)
                .kerning(1)
        }
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
