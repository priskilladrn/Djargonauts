//
//  PlayAlonePickCategoryView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 25/04/23.
//

import SwiftUI

struct PlayAlonePickCategoryView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.05)
                            .padding(.leading, geo.size.width * 0.05)
                            .padding(.trailing, geo.size.width * 0.02)
                        Text("Pick a Category")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(AppColor.title)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        ImageButtonLink(text: "Technology", imageName: "tech_category", destination: EmptyView())
                            .padding(.trailing, geo.size.width * 0.1)
                        
                        ImageButtonLink(text: "Design", imageName: "design_category", destination: EmptyView())
                    }
                    .padding(.bottom, geo.size.height * 0.055)
                    .padding(.top, geo.size.height * 0.08)
                    
                    HStack {
                        ImageButtonLink(text: "Gaming", imageName: "game_category", destination: EmptyView())
                            .padding(.trailing, geo.size.width * 0.1)
                        
                        ImageButtonLink(text: "Accounting", imageName: "accounting_category", destination: EmptyView())
                    }
                    
                    Spacer()
                    
                    Button {
                        let categories = ["Tech", "Design", "Gaming", "Accounting"]
                        
                        jargonListVM.searchCategory(category: categories.randomElement()!)
                        
                    } label: {
                        BorderedButtonView(text: "Randomize", destination: RandomView())
                    }
                    .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PlayAlonePickCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        Group {
            PlayAlonePickCategoryView()
                .environmentObject(JargonListViewModel(context: viewContext))
                .environment(\.colorScheme, .light)

            PlayAlonePickCategoryView()
                .environmentObject(JargonListViewModel(context: viewContext))
                .environment(\.colorScheme, .dark)
        }
    }
}
