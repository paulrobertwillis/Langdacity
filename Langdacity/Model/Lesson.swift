//
//  Lesson.swift
//  Langdacity
//
//  Created by Paul Willis on 02/08/2021.
//

import Foundation

class Lesson: CustomStringConvertible, Codable, Comparable {
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.UUID == rhs.UUID
    }
    
    static func < (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.UUID < rhs.UUID
    }

    var description: String { return UUID }
    
    private static var identifierFactory = 0
    
    var UUID: String
    var cards: [Card]
    
    init(cards: [Card]) throws {
        self.UUID = try Lesson.createUniqueIdentifier()
        self.cards = cards
    }
    
    enum CodingKeys: CodingKey {
        case UUID
        case cards
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.UUID = try container.decode(String.self, forKey: .UUID)
        self.cards = try container.decode([Card].self, forKey: .cards)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(UUID, forKey: .UUID)
        try container.encode(cards, forKey: .cards)
    }

    static private func createUniqueIdentifier() throws -> String {
        Lesson.identifierFactory += 1
        
        let prefix = "LSSN-"
        let id = Lesson.identifierFactory
        
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
    }

    
}
