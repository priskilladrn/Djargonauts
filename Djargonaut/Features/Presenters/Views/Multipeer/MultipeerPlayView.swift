//
//  MultipeerPlayView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 29/04/23.
//

import SwiftUI

struct MultipeerPlayView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "star")
                Text("[score]")
            }
            Spacer()
            
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
            
            Spacer()
            
            Text("[time]")
        }
        .padding(.horizontal, 16)
    }
}

struct MultipeerPlayView_Previews: PreviewProvider {
    static var previews: some View {
        MultipeerPlayView()
    }
}
