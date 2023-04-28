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
            VStack(spacing: 0){
                HStack{
                    Text("Hi, Djargonauts")
                        .font(.system(size: 18))
                        .bold()
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                }
                .padding([.horizontal, .bottom], 16)
                HStack {
                    Spacer()
                    VStack (alignment: .leading, spacing: 10){
                        Text(randomJargon?.category ?? "")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(AppColor.defReverse))
                            .foregroundColor(AppColor.defReverse)
                            .font(.system(size: 14))
                        HStack {
                            Text(randomJargon?.base ?? "")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(AppColor.defReverse)
                            Spacer()
                            
                            Button{
                                randomJargon = jargonListVM.jargonList.randomElement()
                            } label: {
                                Image(systemName: "shuffle")
                                    .foregroundColor(AppColor.secondary)
                            }
                        }
                        
                        Divider()
                            .overlay(AppColor.defReverse)
                        
                        Text(randomJargon?.desc ?? "")
                            .foregroundColor(AppColor.defReverse)
                            .font(.system(size: 15, weight: .medium))
                        
                        
                        NavigationLink{
                            // destination
                        } label: {
                            Text("Read More >")
                                .underline()
                                .font(.system(size: 12))
                                .foregroundColor(AppColor.secondary)                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.55)
                }
                .background(
                    ZStack (alignment: .top){
                        RoundedRectangle(cornerRadius: 32)
                            .fill(AppColor.purpleDark)
                            .opacity(0.8)
                        RoundedRectangle(cornerRadius: 32)
                            .strokeBorder(AppColor.purple, lineWidth: 3)
                            .opacity(0.8)
                        Image("home_astronot")
                            .resizable()
                            .scaledToFill()
                            .padding(.top, -16)
                    }
                )
                .frame(height: 220)
                .padding(.horizontal, 16)
                
                Spacer()
                
                Text("Select Mode")
                    .font(.system(size: 21))
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
                
                Button{
                    
                } label: {
                    ZStack {
                        Image("home_how_to_play_btn")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, -10)
                        Text("How To Play")
                            .foregroundColor(AppColor.def)
                            .textCase(.uppercase)
                            .font(.system(size: 12))
                            .underline()
                    }
                    .frame(width: 75)
                }
                
                
                Image("home_how_to_play_rock")
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
