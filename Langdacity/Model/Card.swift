//
//  Card.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import Foundation

class Card {
    
    var english: String
    var french: String
    var dateNextRevise: Date
    var notes: [Note]?
    
    init(english: String, french: String) {
        self.english = english
        self.french = french
        self.dateNextRevise = NSDate() as Date
        self.notes = []
        
        let englishToFrench = Note(translateFrom: english, translateTo: french)
        let frenchToEnglish = Note(translateFrom: french, translateTo: english)
        
    }

    func setDateNextRevise() {
        // TODO change how this is calculated
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: dateNextRevise)!
        print("\(toString()): \(modifiedDate)")
        dateNextRevise = modifiedDate
    }
    
    func toString() -> String {
        return english
    }
    
//    func notesDueToRevise() -> [Note] {
//        return notes
//    }

}
