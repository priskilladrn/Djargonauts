//
//  JargonsViewModel.swift
//  Djargonaut
//
//  Created by Naufal R. Ariekananda on 02/05/23.
//

import Foundation
import CoreData

class CountryCodeViewModel: ObservableObject {
    //MARK: vars
    private (set) var context: NSManagedObjectContext
    private var jargons = loadCSV(from: "Suggestion Data")
    @Published var jargonList: [Jargon] = []
    let sections = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    //MARK: init
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func populate() {
        let fetchRequest: NSFetchRequest<Jargon> = Jargon.fetchRequest()
        
        
        do {
        jargonList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    //MARK: functions
}
