//
//  PlayAlonePickCategoryView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 25/04/23.
//

import SwiftUI

struct PlayAlonePickCategoryView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    @Environment(\.colorScheme) var colorScheme
    
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
                        Button {
                            
                        } label: {
                            VStack{
                                Image("tech_category")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * 0.3)
                                Text("Technology")
                                    .font(.title3)
                                    .foregroundColor(AppColor.title)
                            }
                        }
                        .padding(.trailing, geo.size.width * 0.1)
                        
                        Button {
                            
                        } label: {
                            VStack{
                                Image("design_category")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * 0.3)
                                Text("Design")
                                    .font(.title3)
                                    .foregroundColor(AppColor.title)
                            }
                        }
                    }
                    .padding(.bottom, geo.size.height * 0.055)
                    .padding(.top, geo.size.height * 0.08)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            VStack{
                                Image("game_category")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * 0.3)
                                Text("Gaming")
                                    .font(.title3)
                                    .foregroundColor(AppColor.title)
                            }
                        }
                        .padding(.trailing, geo.size.width * 0.1)
                        
                        Button {
                            
                        } label: {
                            VStack{
                                Image("accounting_category")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * 0.3)
                                Text("Accounting")
                                    .font(.title3)
                                    .foregroundColor(AppColor.title)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill()
                                .foregroundColor(AppColor.secondary)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(AppColor.title, lineWidth: 3)
                                })
                            Text("Randomize")
                                .foregroundColor(Color("Title"))
                        }
                    }
                    .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
                    
                    Spacer()
                }
            }
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
