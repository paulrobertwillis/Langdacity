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
    var students: [Student]
    var language: language
    var UUID: Int
    
    static var identifierFactory = 0
    
    enum language: String, Codable {
        case french
        case spanish
        case german
    }
    
    init(name: String, language: language) {
        self.name = name
        self.students = []
        self.language = language
        self.UUID = Class.createUniqueIdentifier()
    }
    
    static private func createUniqueIdentifier() -> Int {
        Class.identifierFactory += 1
        return Class.identifierFactory
    }

}
