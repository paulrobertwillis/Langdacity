//
//  Card.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import Foundation

class Card: CustomStringConvertible, Codable {
    var description: String { return "Card '\(english)'"}
    
    //TODO: rename hardcoded variables to generics
    var english: String
    var french: String
    var notes: [Note]
    
    enum CodingKeys: CodingKey {
        case english
        case french
        case notes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.english = try container.decode(String.self, forKey: .english)
        self.french = try container.decode(String.self, forKey: .french)
        self.notes = try container.decode([Note].self, forKey: .notes)

//        createNotes()
    }
    
    init(english: String, french: String) {
        self.english = english
        self.french = french
        self.notes = []
        
        createNotes()
    }
    
    func createNotes() {
        //TODO: remove hardcoded "toFrench"/"toEnglish" values
        if let note = Note.createNote(card: self, direction: "toFrench") {
            notes.append(note)
        }
        if let note = Note.createNote(card: self, direction: "toEnglish") {
            notes.append(note)
        }
    }
    
//    func toString() -> String {
//        return english
//    }
}
