//
//  Teacher.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

class Teacher: User {
//    override var description: String { return "Teacher: \(UUID)"}
    
    var title: titleEnum
    var classes: [String]
    
    enum titleEnum: String, Codable {
        case Mr = "Mr"
        case Ms = "Ms"
        case Miss = "Miss"
        case Mrs = "Mrs"
    }
    
    static var identifierFactory = 0

    init(title: titleEnum, forename: String, surname: String, email: String, classes: [String] = []) throws {
        self.title = title
        // TODO: make class UUIDs an array
        self.classes = classes
        
        try super.init(forename: forename, surname: surname, email: email)
        
        self.UUID = try Teacher.createUniqueIdentifier()
    }
    
    enum CodingKeys: CodingKey {
        case title
        case classes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(titleEnum.self, forKey: .title)
        self.classes = try container.decode([String].self, forKey: .classes)
        
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(title, forKey: .title)
            try container.encode(classes, forKey: .classes)
        
        try super.encode(to: encoder)
    }
        
    private static func createUniqueIdentifier() throws -> String {
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
