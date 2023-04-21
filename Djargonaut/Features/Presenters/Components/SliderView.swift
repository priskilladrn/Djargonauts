//
//  SliderView.swift
//  Djargonaut
//
//  Created by Wita Dewisari Tasya on 20/04/23.
//

import SwiftUI

struct SliderView: View {
    let images = ["help_bumi_1", "help_bumi_2", "help_bumi_3"]
    var body: some View {
        VStack{
            TabView{
                ForEach (0..<3) { i in
                    Image("\(images[i])").resizable().scaledToFit()
                }
            }.tabViewStyle(PageTabViewStyle())
        }.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
