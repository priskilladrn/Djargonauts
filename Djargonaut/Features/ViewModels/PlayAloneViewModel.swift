//
//  PlayAloneViewModel.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import Foundation
import CoreData

class PlayAloneViewModel {
    private var resultSet = Set<Jargon>()
    private var jargonListVM: JargonListViewModel?
    
    init(jargonListVM: JargonListViewModel) {
        self.jargonListVM = jargonListVM
    }
    
    init() {}
    
    func getTenRandomQuestions() -> Array<Jargon> {
        let categories = ["Technology", "Design", "Game", "Accounting"]
        
        jargonListVM!.searchCategory(category: categories.randomElement()!)
        
        while resultSet.count <= 10 {
            let randomIndex = Int(arc4random_uniform(UInt32(jargonListVM!.jargonList.count)))
            resultSet.insert(jargonListVM!.jargonList[randomIndex])
        }
        
        print(resultSet)
        
        return Array(resultSet)
    }
    

    func getTenQuestions(category: String) -> Array<Jargon> {
        jargonListVM!.searchCategory(category: category)
        
        while resultSet.count <= 10 {
            let randomIndex = Int(arc4random_uniform(UInt32(jargonListVM!.jargonList.count)))
            resultSet.insert(jargonListVM!.jargonList[randomIndex])
        }
        
        print(resultSet)
        
        return Array(resultSet)
    }
    
    func randomOption(answers: [String]) -> Array<String> {
        var answersSet = Set<String>()
        
        while answers.count < 2 {
            let randomIndex = Int(arc4random_uniform(UInt32(answers.count)))
            answersSet.insert(answers[randomIndex])
        }
        
        return Array(answersSet)
    }
//    
//    func randomWord(category: String) -> String {
//        jargonListVM!.searchCategory(category: category)
//        
//        return (jargonListVM!.jargonList.randomElement()!.base)!
//    }
}
