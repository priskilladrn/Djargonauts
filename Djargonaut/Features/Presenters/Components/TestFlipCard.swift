//
//  TestFlipCard.swift
//  Djargonaut
//
//  Created by Jevon Levin on 04/05/23.
//

import SwiftUI
import MGFlipView
struct TestFlipCard: View {
    @State private var isFlipped = false
    @State private var frontView = AnyView(Text("asd").background(.red))
    @State private var backView = AnyView(Text("jkl").background(.blue))
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack {
            FlipView(frontView: {frontView}, backView: {backView}, flipped: $isFlipped, flipAxis: .y)
            Button("flip"){
                isFlipped.toggle()
            }
            Button("flip & change back"){
                
                backView = AnyView(Text("ffff").background(.green))
                isFlipped.toggle()
            }
            Button("flip & change front"){
                
                frontView = AnyView(Text("gggg").background(.yellow))
                isFlipped.toggle()
            }
        }
    }
}

struct TestFlipCard_Previews: PreviewProvider {
    static var previews: some View {
        TestFlipCard()
    }
}
