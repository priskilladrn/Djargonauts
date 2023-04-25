//
//  CoreDataViewModel.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 24/04/23.
//

import Foundation
import CoreData

class JargonListViewModel: ObservableObject {
    
    private (set) var context: NSManagedObjectContext
    private var jargons = loadCSV(from: "Suggestion Data")
    @Published var jargonList: [Jargon] = []
    
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
    
    func populate() {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        
        saveAll()
        
        do {
        jargonList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    func searchWord(word: String) {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "base = %@", word)
        
        do {
            jargonList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    func searchCategory(category: String) {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category = %@", category)
        
        do {
            jargonList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
}
