//
//  Student.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

class Student: CustomStringConvertible, Codable {
    var description: String { return "Student: \(UUID)"}

    var forename: String
    var surname: String
    var UUID: Int
    var classUUID: Int
    var points: Int
    
    static var identifierFactory = 0

    init(forename: String, surname: String, classUUID: Int) {
        self.forename = forename
        self.surname = surname
        self.UUID = 0
        self.classUUID = classUUID
        self.points = 0
    }
    
    static private func createUniqueIdentifier() -> Int {
        Student.identifierFactory += 1
        return Student.identifierFactory
    }

}
