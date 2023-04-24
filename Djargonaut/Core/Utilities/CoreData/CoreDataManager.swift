//
//  CoreDataManager.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 24/04/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        container = NSPersistentContainer(name: "DjargonautModel")
        
        container.loadPersistentStores { desc, error in
            if let error {
                fatalError("Core Data failed: \(error)")
            }
        }
    }
}
