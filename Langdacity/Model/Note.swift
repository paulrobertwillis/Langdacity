//
//  Note.swift
//  Langdacity
//
//  Created by Paul Willis on 25/07/2021.
//

import Foundation

class Note: CustomStringConvertible{
    var description: String { return "Note \(UUID)"}
    
    let translateFrom: String
    let translateTo: String
    var dateNextRevise: Date
    var UUID: Int
    
    static var identifierFactory = 0

    
    private init(translateFrom: String, translateTo: String) {
        self.translateFrom = translateFrom
        self.translateTo = translateTo
        self.dateNextRevise = Date(timeIntervalSinceNow: 0)
        self.UUID = Note.getUniqueIdentifier()
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
    
    static func getUniqueIdentifier() -> Int {
        Note.identifierFactory += 1
        return Note.identifierFactory
    }
        
    func setDateNextRevise() {
        // TODO change how this is calculated
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: dateNextRevise)!
        
        let formattedDateNextRevise = dateNextRevise.getFormattedDate(format: "yyyy-MM-dd")
        let formattedModifiedDate = modifiedDate.getFormattedDate(format: "yyyy-MM-dd")
        
        print("\(toString()): \(formattedDateNextRevise) changed to \(formattedModifiedDate)")
        dateNextRevise = modifiedDate
    }
    
    func toString() -> String {
        return "Note UUID: \(String(UUID))"
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


