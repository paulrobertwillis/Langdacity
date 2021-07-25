//
//  Card.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import Foundation

class Card: Codable {
    
    var english: String
    var french: String
    var notes: [Note]
    
    enum CodingKeys: CodingKey {
        case english
        case french
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.english = try container.decode(String.self, forKey: .english)
        self.french = try container.decode(String.self, forKey: .french)
        self.notes = []
        
        createNotes()
    }
    
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
    
    static func decodeFromJSON() -> [Card]? {
        guard
            let path = Bundle.main.path(forResource: "Lesson01", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        else {
            print("Error: cannot locate JSON file")
            return nil
        }
        
        do {
            print("attempting cards array creation")
            let cards: [Card] = try JSONDecoder().decode([Card].self, from: data)
            return cards
        } catch {
            // handle error
            print("error in decoding JSON file")
        }
        
        return nil
    }
}
