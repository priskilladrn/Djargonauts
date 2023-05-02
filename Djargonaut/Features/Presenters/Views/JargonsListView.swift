//
//  JargonsItemView.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 02/05/23.
//

import SwiftUI

struct JargonListView: View {
    //MARK: vars
    let jargonModel: JargonModel
    
    //MARK: init
    init(jargonModel: JargonModel) {
        self.jargonModel = jargonModel
    }
    
    //MARK: body
    var body: some View {
        ScrollView {
            List()
        }
        VStack {
            HStack {
                VStack {
                    Text("\(jargonModel.base)")
                        .font(Font.system(size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .padding(.top, 7)
                        .padding(.bottom, 7)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    Text("\(jargonModel.category)")
                        .font(Font.system(size: 16))
                        .foregroundColor(.gray)
                        .fontWeight(.light)
                        .padding(.top, 7)
                        .padding(.bottom, 7)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                
            }
        }
    }
}
