//
//  Jargon.swift
//  Djargonaut
//
//  Created by Priskilla Adriani on 24/04/23.
//

import Foundation

struct JargonModel: Identifiable {
    var base: String
    var jargon: String
    var category: String
    var desc: String
    var partOfSpeech: String
    var id = UUID()

    init(raw: [String]) {
        self.base = raw[0]
        self.jargon = raw[1]
        self.category = raw[2]
        self.desc = raw[3]
        self.partOfSpeech = raw[4]
    }
}

func loadCSV(from csvName: String) -> [JargonModel] {
    var csvToData = [JargonModel]()
    
    //locate csv file
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return []
    }
    
    //convert the content of the file into a very long string
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return []
    }
    
    //split the long string into an array of "rows" of data. Each row is a string
    //detect "\n" carriage return, then split
    var rows = data.components(separatedBy: "\n")
    
    //remove header rows
    //count the number of header before removing
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    //now loop around each row and split into columns
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let jargonStruct = JargonModel.init(raw: csvColumns)
            csvToData.append(jargonStruct)
        }
    }
    
    return csvToData
}
