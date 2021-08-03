//
//  Class.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

class Class: CustomStringConvertible, Codable, Comparable {
    static func == (lhs: Class, rhs: Class) -> Bool {
        return lhs.UUID == rhs.UUID
    }
    
    static func < (lhs: Class, rhs: Class) -> Bool {
        return lhs.name < rhs.name
    }
    
    var description: String { return "Class: \(UUID)"}
    
    var name: String
    var students: [String]
    var language: language
    var UUID: String
    
    static var identifierFactory = 0
    
    enum language: String, Codable {
        case french
        case spanish
        case german
    }
    
    init(name: String, language: language) throws {
        self.name = name
        self.students = []
        self.language = language
        self.UUID = try Class.createUniqueIdentifier()
    }
        
    static private func createUniqueIdentifier() throws -> String {
        Teacher.identifierFactory += 1
        
        let prefix = "CLSS-"
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
