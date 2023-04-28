//
//  HomeView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 24/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var jargonListVM: JargonListViewModel
    @State private var randomJargon: Jargon?
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack{
                    Text("Hi, Djargonauts")
                        .font(.system(size: 18))
                        .bold()
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                }
                .padding(.horizontal, 16)
                ZStack {
                    
                    Image("home_astronot")
                        .resizable()
                        .scaledToFill()
//                        .frame(width: geometry.size.width, height: 280) // TODO: test other devices' height
                    HStack {
                        Spacer()
                        VStack (alignment: .leading, spacing: 10){
                            Text(randomJargon?.category ?? "")
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(AppColor.purple)
                                .cornerRadius(12)
                            HStack {
                                Text(randomJargon?.base ?? "")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                
                                Button{
                                    randomJargon = jargonListVM.jargonList.randomElement()
                                } label: {
                                    Image(systemName: "shuffle")
                                        .foregroundColor(AppColor.secondary)
                                }
                            }
                            
                            Divider()
                                .overlay(AppColor.def)
                            
                            Text(randomJargon?.desc ?? "")
                            
                            HStack{
                                Text("Read More")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(AppColor.secondary)
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.55)
                    }
                }
                .background(AppColor.purpleDark.opacity(0.8))
                .frame(height: 220)
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                Spacer()
                
                Text("Select Mode")
                    .bold()
                    .textCase(.uppercase)
                    .foregroundColor(AppColor.def)
                    .kerning(4)
                HStack (spacing: 30){
                    ImageButtonLink(text: "Solo Mode", imageName: "home_solo", destination: EmptyView())
                    ImageButtonLink(text: "Multiplayer", imageName: "home_1v1", destination: MultipeerInitView())
                }
                .padding()
                
                Spacer()
                
                Image("home_how_to_play")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, -geometry.safeAreaInsets.bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear{
            jargonListVM.populate()
            randomJargon = jargonListVM.jargonList.randomElement()!
        }
    }
        
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
