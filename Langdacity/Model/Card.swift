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
    var notes: [Note]
    
    init(english: String, french: String) {
        self.english = english
        self.french = french
        self.notes = []
        
        createNotes()
    }
    
    func createNotes() {
        if let note = Note.createNote(card: self, direction: "toFrench") {
            notes.append(note)
        }
        if let note = Note.createNote(card: self, direction: "toEnglish") {
            notes.append(note)
        }
    }
    
    func toString() -> String {
        return english
    }
    
//    func notesDueToRevise() -> [Note] {
//        return notes
//    }

}
