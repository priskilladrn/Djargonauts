//
//  PlayAlonePickCategoryView.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 25/04/23.
//

import SwiftUI

struct PlayAlonePickCategoryView: View {
    
    @EnvironmentObject var jargonListVM: JargonListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var allJargons = [Jargon]()
    @State var questions = Array<Jargon>()
    @State var playAloneVM: PlayAloneViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                
                VStack {
                    CustomBackButton(text: "Pick a Category")
                        .frame(height: geo.size.height * 0.05)
                    
                    Spacer()
                    
                    HStack {
                        ImageButtonLink(text: "Technology", imageName: "tech_category", destination: PlayAloneQuestionView(questions: questions))
                            .simultaneousGesture(TapGesture().onEnded {
                                questions = playAloneVM.getTenQuestions(category: "Tech")
                            })
                            .padding(.trailing, geo.size.width * 0.1)
                        
                        ImageButtonLink(text: "Design", imageName: "design_category", destination: PlayAloneQuestionView(questions: questions))
                            .simultaneousGesture(TapGesture().onEnded {
                                questions = playAloneVM.getTenQuestions(category: "Design")
                            })
                    }
                    .padding(.bottom, geo.size.height * 0.055)
                    .padding(.top, geo.size.height * 0.08)
                    
                    HStack {
                        ImageButtonLink(text: "Gaming", imageName: "game_category", destination: PlayAloneQuestionView(questions: questions))
                            .simultaneousGesture(TapGesture().onEnded {
                                questions = playAloneVM.getTenQuestions(category: "Gaming")
                            })
                            .padding(.trailing, geo.size.width * 0.1)
                        
                        ImageButtonLink(text: "Accounting", imageName: "accounting_category", destination: PlayAloneQuestionView(questions: questions))
                            .simultaneousGesture(TapGesture().onEnded {
                                questions = playAloneVM.getTenQuestions(category: "Accounting")
                            })
                    }
                    
                    Spacer()
                    
                    BorderedButtonView(text: "Randomize", destination: RandomView(questions: questions))
                        .simultaneousGesture(TapGesture().onEnded{
                            questions = playAloneVM.getTenRandomQuestions()
                        })
                        .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.07)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                playAloneVM = PlayAloneViewModel(jargonListVM: jargonListVM)
            }
        }
    }
}

//struct PlayAlonePickCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = CoreDataManager.shared.container.viewContext
//        Group {
//            PlayAlonePickCategoryView()
//                .environmentObject(JargonListViewModel(context: viewContext))
//                .environment(\.colorScheme, .light)
//
//            PlayAlonePickCategoryView()
//                .environmentObject(JargonListViewModel(context: viewContext))
//                .environment(\.colorScheme, .dark)
//        }
//    }
//}
