//
//  RandomView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 30/04/23.
//

import SwiftUI

struct RandomView: View {
    @State var CurrentColor = Color.blue
    @State var scaleEffect = 1.0
    @State var navigateToCategoryPage = false
    
    var questions: [Jargon]
    static var colors: [Color] = [AppColor.secondary, AppColor.purple, AppColor.title, AppColor.purpleDark]
    static var randomColor: Color {
        colors.randomElement() ?? .blue
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Randomizing")
                        .foregroundColor(Color("Title"))
                        .fontWeight(.bold)
                        .kerning(1)
                        .font(.system(size: 24))

                    HStack {
                        ForEach(0..<3, id: \.self) { i in
                        Circle()
                            .frame(width: 15, height: 15)
                            .scaleEffect(
                                CGSize(width: scaleEffect, height: scaleEffect), anchor: .center)
                            .foregroundColor(RandomView.randomColor)
                            .animation(
                                Animation
                                    .interpolatingSpring(mass: 8, stiffness: 10, damping: 5, initialVelocity: 0.5)
                                    .repeatForever(autoreverses: true)
                                    .speed(60)
                                        ,value: self.CurrentColor)
                                    .foregroundColor(RandomView.randomColor)
                                    .onAppear() {
                                        CurrentColor = Color.purple
                                        scaleEffect = 0.8
                                    }
                            }
                        }
                        Spacer()
                            .frame(height: 450)
                    }
                }
            
                NavigationLink(
                    destination: PlayAloneQuestionView(questions: questions),
                    isActive: $navigateToCategoryPage,
                    label: {}
                )
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                navigateToCategoryPage = true
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Pick a Category")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColor.title)
            }
        }
    }
}
    
//    struct RandomView_Previews: PreviewProvider {
//        static var previews: some View {
//            RandomView()
//        }
//    }
