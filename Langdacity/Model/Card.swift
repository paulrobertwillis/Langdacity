//
//  Card.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import Foundation

class Card: CustomStringConvertible, Codable, Comparable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.UUID == rhs.UUID
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.UUID < rhs.UUID
    }
        
    var description: String { return "Card '\(english)'"}
    
    private static var identifierFactory = 0
    
    //TODO: rename hardcoded variables to generics
    var english: String
    var french: String
    var notes: [Note]
    var UUID: String
    
    enum CodingKeys: CodingKey {
        case english
        case french
        case notes
        case UUID
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.english = try container.decode(String.self, forKey: .english)
        self.french = try container.decode(String.self, forKey: .french)
        self.notes = try container.decode([Note].self, forKey: .notes)
        self.UUID = try container.decode(String.self, forKey: .UUID)
    }
    
    init(english: String, french: String) {
        self.english = english
        self.french = french
        self.notes = []
        self.UUID = Card.createUniqueIdentifier(prefix: "CARD-")

        createNotes()
    }
    
    private func createNotes() {
        //TODO: remove hardcoded "toFrench"/"toEnglish" values
        if let note = try? Note.createNote(card: self, direction: "toFrench") {
            notes.append(note)
        }
        if let note = try? Note.createNote(card: self, direction: "toEnglish") {
            notes.append(note)
        }
    }
    
    static private func createUniqueIdentifier(prefix: String) -> String {
        do {
            Card.identifierFactory += 1
        
            let id = Card.identifierFactory
            
            guard id >= 1 else {
                throw Errors.uuidErrors.valueTooLow(minValue: 1, actualValue: id)
            }
            
            guard id <= 9999 else {
                throw Errors.uuidErrors.valueTooHigh(maxValue: 9999, actualValue: id)
            }
            
            switch id {
            case 1...9:
                return "\(prefix)000" + String(id)
            case 10...99:
                return "\(prefix)00" + String(id)
            case 100...999:
                return "\(prefix)0" + String(id)
            case 1000...9999:
                return "\(prefix)" + String(id)
            default:
                throw Errors.uuidErrors.valueNotInteger(actualValue: String(id))
            }
        } catch Errors.uuidErrors.valueTooLow(let minValue, let actualValue) {
            print("Error in \(self) function \(#function): Assigned ID Int is too low. minValue: \(minValue), actual value: \(actualValue)")
        } catch Errors.uuidErrors.valueTooHigh(let maxValue, let actualValue) {
            print("Error in \(self) function \(#function): Assigned ID Int is too high. maxValue: \(maxValue), actual value: \(actualValue)")
        } catch Errors.uuidErrors.valueNotInteger(let actualValue) {
            print("Error in \(self) function \(#function): Assigned ID must be Int. Actual value: \(actualValue)")
        } catch {
            print("Error in \(self) function \(#function): Unknown error")
        }
        
        return ""
    }

}
