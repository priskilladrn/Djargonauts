//
//  HomeView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 24/04/23.
//

import SwiftUI

import LottieUI
struct HomeView: View {
    @EnvironmentObject var jargonListVM: JargonListViewModel
    @State private var randomJargon: Jargon?
    @State var isPresented = false //Variabel popup
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                HStack{
                    Text("Hi, Djargonauts")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(AppColor.title)
                    Spacer()
                    
                    NavigationLink{
                        SearchPageView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(AppColor.title)
                    }
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
                                    .stroke(.white))
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                        HStack {
                            Text(randomJargon?.base ?? "")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            
                            Button{
                                randomJargon = jargonListVM.jargonList.randomElement()
                            } label: {
                                Image(systemName: "shuffle")
                                    .foregroundColor(AppColor.secondary)
                            }
                        }
                        
                        Divider()
                            .overlay(.white)
                        
                        Text(randomJargon?.desc ?? "")
                            .foregroundColor(.white)
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
                    .foregroundColor(AppColor.title)
                    .kerning(4)
                HStack (spacing: 32){
                    ImageButtonLink(text: "Solo Mode", imageName: "home_solo", destination: PlayAlonePickCategoryView(playAloneVM: PlayAloneViewModel()).toolbarRole(.editor))
                    ImageButtonLink(text: "Multiplayer", imageName: "home_1v1", destination: MultipeerInitView())
                }
                .padding()
                
                Spacer()
                
                Button{
                    isPresented = true
                } label: {
                    ZStack {
                        LottieView(state: LUStateData(type: .name("how-to-play", .main), loopMode: .loop))
                            .scaleEffect(1.5)
                            .scaledToFill()
                            .frame(width: 72, height: 128)
                            .padding(.bottom, -10)
                        //                        Image("home_how_to_play_btn")
                        //                            .resizable()
                        //                            .scaledToFit()
                        //                            .padding(.bottom, -10)
                        Text("How To Play")
                            .foregroundColor(.black)
                            .textCase(.uppercase)
                            .font(.system(size: 12, weight: .bold))
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
            .navigationBarBackButtonHidden(true)
        }
        .sheet(isPresented: $isPresented) {
            PopupView(isPresented: $isPresented)
        }
        .onAppear{
            jargonListVM.populate()
            randomJargon = jargonListVM.jargonList.randomElement()!
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.container.viewContext
        HomeView()
            .environmentObject(JargonListViewModel(context: viewContext))
    }
}
