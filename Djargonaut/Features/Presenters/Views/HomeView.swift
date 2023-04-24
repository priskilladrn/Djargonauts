//
//  HomeView.swift
//  Djargonaut
//
//  Created by Jevon Levin on 24/04/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack (alignment: .top){
                    Image("home_astronot")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 280) // TODO: test other devices' height
                        .padding(.top, -geometry.safeAreaInsets.top)
                    
                    HStack {
                        Spacer()
                        VStack (alignment: .leading, spacing: 10){
                            Text("Technology")
                            HStack {
                                Text("Deprecated")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                
                                Button{
                                    
                                } label: {
                                    Image(systemName: "shuffle")
                                        .foregroundColor(Color("Secondary"))
                                }
                            }
                            
                            Divider()
                                .overlay(.black)
                            
                            Text("Something is acknowledged, but discouraged.")
                            
                            HStack{
                                Text("Read More")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(Color("Secondary"))
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.6)
                    }
                }
                
                Spacer()
                
                ImageButtonLink(text: "Search", imageName: "home_search", destination: SearchPageView())
                
                HStack (spacing: 30){
                    ImageButtonLink(text: "Solo", imageName: "home_solo", destination: SearchPageView())
                    ImageButtonLink(text: "1 VS 1", imageName: "home_1v1", destination: SearchPageView())
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
