//
//  SliderView.swift
//  Djargonaut
//
//  Created by Wita Dewisari Tasya on 20/04/23.
//

import SwiftUI

struct SliderView: View {
    let images = ["help_bumi_1", "help_bumi_2"]
    let helpHeading = ["Single Player Guide", "Multi Player Guide"]
    let items = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent quis leo tempus, rutrum lectus non, pharetra magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent quis leo tempus, rutrum lectus non, pharetra magna. ", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent quis leo tempus, rutrum lectus non, pharetra magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent quis leo tempus, rutrum lectus non, pharetra magna. "]
    
    var body: some View {
        VStack{
            TabView{
                ForEach (0..<2) { i in
                    VStack{
                        Text("\(helpHeading[i])").font(.headline)
                            .padding()
                        Image("\(images[i])").resizable().scaledToFit()
                        Text("\(items[i])")
                            .padding()
                    }
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
