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
        if colorScheme == .light {
            LightView
        } else {
            DarkView
        }
    }
}

private var LightView: some View {
    GeometryReader { geo in
        ZStack {
            Image("bg_light_mode")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        VStack{
                            Image("tech_light")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Technology")
                                .font(.title3)
                                .foregroundColor(Color("Title"))
                        }
                    }
                    .padding(.trailing, geo.size.width * 0.1)
                    
                    Button {
                        
                    } label: {
                        VStack{
                            Image("design_light")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Design")
                                .font(.title3)
                                .foregroundColor(Color("Title"))
                        }
                    }
                }
                .padding(.bottom, geo.size.height * 0.055)
                .padding(.top, geo.size.height * 0.08)
                
                HStack {
                    Button {
                        
                    } label: {
                        VStack{
                            Image("game_light")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Gaming")
                                .font(.title3)
                                .foregroundColor(Color("Title"))
                        }
                    }
                    .padding(.trailing, geo.size.width * 0.1)
                    
                    Button {
                        
                    } label: {
                        VStack{
                            Image("accounting_light")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Accounting")
                                .font(.title3)
                                .foregroundColor(Color("Title"))
                        }
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

private var DarkView: some View {
    GeometryReader { geo in
        ZStack {
            Image("bg_dark_opacity_50%")
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        VStack{
                            Image("tech_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Technology")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, geo.size.width * 0.1)
                    
                    Button {
                        
                    } label: {
                        VStack{
                            Image("design_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Design")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, geo.size.height * 0.055)
                .padding(.top, geo.size.height * 0.08)
                
                HStack {
                    Button {
                        
                    } label: {
                        VStack{
                            Image("game_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Gaming")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, geo.size.width * 0.1)
                    
                    Button {
                        
                    } label: {
                        VStack{
                            Image("accounting_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                            Text("Accounting")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
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
