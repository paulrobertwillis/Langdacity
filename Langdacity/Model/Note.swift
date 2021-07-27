//
//  Note.swift
//  Langdacity
//
//  Created by Paul Willis on 25/07/2021.
//

import Foundation

class Note: CustomStringConvertible, Codable {
    var description: String { return "Note \(UUID)"}
    
    let translateFrom: String
    let translateTo: String
    var dateNextRevise: Date
    var UUID: Int
    
    enum status {
        case learning
        case learnt
        case relearning
    }
    
    static var identifierFactory = 0

    private init(translateFrom: String, translateTo: String) {
        self.translateFrom = translateFrom
        self.translateTo = translateTo
        self.dateNextRevise = Date(timeIntervalSinceNow: 0)
        self.UUID = Note.createUniqueIdentifier()
    }
    
    static func createNote(card: Card, direction: String) -> Note? {
        if direction == "toFrench" {
            return Note.init(translateFrom: card.english, translateTo: card.french)
        } else if direction == "toEnglish" {
            return Note.init(translateFrom: card.french, translateTo: card.english)
        } else {
            return nil
        }
    }
    
    static private func createUniqueIdentifier() -> Int {
        Note.identifierFactory += 1
        return Note.identifierFactory
    }
        
    func setDateNextRevise() {
        // TODO change how this is calculated
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: dateNextRevise)!
        
        let formattedDateNextRevise = dateNextRevise.getFormattedDate(format: "yyyy-MM-dd")
        let formattedModifiedDate = modifiedDate.getFormattedDate(format: "yyyy-MM-dd")
        
        // TODO: Remove this print statement
        print("\(description): \(formattedDateNextRevise) changed to \(formattedModifiedDate)")
        
        dateNextRevise = modifiedDate
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


