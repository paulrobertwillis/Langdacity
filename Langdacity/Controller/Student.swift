//
//  Student.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

class Student: User {
//    override var description: String { return "\(forename) \(surname): #\(UUID)"}

//    var forename: String
//    var surname: String
//    var UUID: String
    //TODO: Allow multiple classes through array
    var classUUID: [Int]
    var points: Int
    
    static var identifierFactory = 0

    init(forename: String, surname: String, email: String, classUUID: [Int] = []) throws {
//        self.forename = forename
//        self.surname = surname
        self.classUUID = classUUID
        self.points = 0
        
        try super.init(forename: forename, surname: surname, email: email)
        
        self.UUID = try Student.createUniqueIdentifier(prefix: "STDT-")
    }
    
    enum CodingKeys: CodingKey {
        case classUUID
        case points
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.classUUID = try container.decode([Int].self, forKey: .classUUID)
        self.points = try container.decode(Int.self, forKey: .points)
        
        try super.init(from: decoder)
    }

    static private func createUniqueIdentifier(prefix: String) throws -> String {
        Student.identifierFactory += 1
        
//        let prefix = "USER-"
        let id = Student.identifierFactory
        
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
    
    func getFullName() -> String {
        return forename + " " + surname
    }

}
