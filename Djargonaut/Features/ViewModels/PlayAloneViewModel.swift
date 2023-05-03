//
//  PlayAloneViewModel.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 02/05/23.
//

import Foundation
import CoreData

class PlayAloneViewModel {
    private let categories = ["Tech", "Design", "Gaming", "Accounting"]
    private var resultSet = Set<Jargon>()
    private var jargonListVM: JargonListViewModel?
    
    init(jargonListVM: JargonListViewModel) {
        self.jargonListVM = jargonListVM
    }
    
    init() {}
    
    func getTenRandomQuestions() -> Array<Jargon> {
        let categories = ["Technology", "Design", "Gaming", "Accounting"]
        
//        jargonListVM!.searchCategory(category: categories.randomElement()!)
        jargonListVM!.searchCategory(category: "Tech")
        
        while resultSet.count < 10 {
            let randomIndex = Int(arc4random_uniform(UInt32(jargonListVM!.jargonList.count)))
            resultSet.insert(jargonListVM!.jargonList[randomIndex])
        }
        
        print(resultSet)
        
        return Array(resultSet)
    }
    

    func getTenQuestions(category: String) -> Array<Jargon> {
        jargonListVM!.searchCategory(category: category)
        
        while resultSet.count < 10 {
            let randomIndex = Int(arc4random_uniform(UInt32(jargonListVM!.jargonList.count)))
            resultSet.insert(jargonListVM!.jargonList[randomIndex])
        }
        
        print(resultSet)
        
        return Array(resultSet)
    }
}
