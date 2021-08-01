//
//  Teacher.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

struct Teacher: CustomStringConvertible, Codable {
    var description: String { return "Teacher: \(UUID)"}
    
    var title: title
    var forename: String
    var surname: String
    var UUID: String
    var classes: [Class]
    
    enum title: String, Codable {
        case Mr = "Mr"
        case Ms = "Ms"
        case Miss = "Miss"
        case Mrs = "Mrs"
    }
    
    static var identifierFactory = 0

    init(title: title, forename: String, surname: String, classes: [Class] = []) throws {
        self.title = title
        self.forename = forename
        self.surname = surname
        self.UUID = try Teacher.createUniqueIdentifier()
        // TODO: make class UUIDs an array
        self.classes = classes
    }
    
    static private func createUniqueIdentifier() throws -> String {
        Teacher.identifierFactory += 1
        
        let prefix = "PROF-"
        let id = Teacher.identifierFactory
        
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
