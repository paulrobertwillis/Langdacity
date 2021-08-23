//
//  User.swift
//  Langdacity
//
//  Created by Paul Willis on 01/08/2021.
//

import Foundation

class User: CustomStringConvertible, Codable, Comparable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.UUID == rhs.UUID
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        if lhs.surname != rhs.surname {
            return lhs.surname < rhs.surname
        } else {
            return lhs.getFullName() < rhs.getFullName()
        }
    }
    
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
        
    func getFullName() -> String {
        return forename + " " + surname
    }

}


