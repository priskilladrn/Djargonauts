//
//  CoreDataViewModel.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 24/04/23.
//

import Foundation
import CoreData

class JargonListViewModel {
    
    private (set) var context: NSManagedObjectContext
    var jargons = loadCSV(from: "Suggestion Data")
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    private func saveAll(){
        do {
            let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
            let dataCount = try context.count(for: fetchRequest)
            if dataCount != jargons.count {
                for jargon in jargons {
                    do {
                        let oneJargon = Jargon(context: context)
                        oneJargon.base = jargon.base
                        oneJargon.jargon = jargon.jargon
                        oneJargon.category = jargon.category
                        oneJargon.desc = jargon.desc
                        oneJargon.partOfSpeech = jargon.partOfSpeech
                        try oneJargon.save()
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func populate() -> [Jargon] {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        
        saveAll()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func searchWord(word: String) -> [Jargon] {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word = %@", word)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func searchCategory(category: String) -> [Jargon] {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category = %@", category)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
