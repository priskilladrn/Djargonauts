//
//  MultipeerPlayView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 29/04/23.
//

import SwiftUI

enum Stage{
    case explain, answer, revealCorrectAnswer
}

struct MultipeerPlayView: View {
    @ObservedObject var vm: MultipeerViewModel
    @State private var currentStage: Stage = .explain
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "star")
                Text("[score]")
            }
            Spacer()
            
            Text("Words")
            ForEach(vm.roomSetting.words, id: \.id){w in
                Text("- \(w.base)")
            }
            
            if currentStage == .explain {
                VStack{
                    HStack{
                        Text("[Category]")
                        Spacer()
                        Text("1 / [total]")
                    }
                    Text("[word]")
                    Divider()
                    Text("[Description]")
                }
                .padding(.vertical)
                .border(AppColor.purpleDark)                
            }
            
            Spacer()
            
            Text("[time]")
        }
        .padding(.horizontal, 16)
    }
}

//struct MultipeerPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipeerPlayView()
//    }
//}
