//
//  User.swift
//  Langdacity
//
//  Created by Paul Willis on 01/08/2021.
//

import Foundation

class User: CustomStringConvertible, Codable {
    var description: String { return UUID}
    
    var forename: String
    var surname: String
    var UUID: String
    var email: String
    
//    private static var userIdentifierFactory = 0
    
    init(forename: String, surname: String, email: String) throws {
        self.forename = forename
        self.surname = surname
        self.UUID = ""
        self.email = email
    }
    
//    static private func createUniqueIdentifier(prefix: String) throws -> String {
//        User.userIdentifierFactory += 1
//
////        let prefix = "USER-"
//        let id = User.userIdentifierFactory
//
//        guard id >= 1 else {
//            throw Errors.uuidErrors.valueTooLow(minValue: 1, actualValue: id)
//        }
//
//        guard id <= 9999 else {
//            throw Errors.uuidErrors.valueTooHigh(maxValue: 9999, actualValue: id)
//        }
//
//        switch id {
//        case 1...9:
//            return "\(prefix)000" + String(id)
//        case 10...99:
//            return "\(prefix)00" + String(id)
//        case 100...999:
//            return "\(prefix)0" + String(id)
//        case 1000...9999:
//            return "\(prefix)" + String(id)
//        default:
//            throw Errors.uuidErrors.valueNotInteger(actualValue: String(id))
//        }
//    }
}


