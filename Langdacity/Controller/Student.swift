//
//  Student.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

class Student: User {
//    static func == (lhs: Student, rhs: Student) -> Bool {
//        return lhs.UUID == rhs.UUID
//    }
//
//    static func < (lhs: Student, rhs: Student) -> Bool {
//        if lhs.surname != rhs.surname {
//            return lhs.surname < rhs.surname
//        } else {
//            return lhs.getFullName() < rhs.getFullName()
//        }
//    }
    
//    override var description: String { return "\(forename) \(surname): #\(UUID)"}

    var classUUID: [String]
    var points: Int
    var notesRevising: [String:Date]
    var accessibleLessons: [String]
    var hasCompletedDailyRevision: Bool
    var revisionStreak: Int
    
    private static var identifierFactory = 0

    init(forename: String, surname: String, email: String, classUUID: [String] = [], lessons: [String] = []) throws {
        self.classUUID = classUUID
        self.points = 0
        self.notesRevising = [:]
        self.accessibleLessons = lessons
        self.hasCompletedDailyRevision = false
        self.revisionStreak = 0
        
        try super.init(forename: forename, surname: surname, email: email)
        
        self.UUID = try Student.createUniqueIdentifier(prefix: "STDT-")
    }
    
    enum CodingKeys: CodingKey {
        case classUUID
        case points
        case notesRevising
        case accessibleLessons
        case hasCompletedDailyRevision
        case revisionStreak
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.classUUID = try container.decode([String].self, forKey: .classUUID)
        self.points = try container.decode(Int.self, forKey: .points)
        self.notesRevising = try container.decode([String:Date].self, forKey: .notesRevising)
        self.accessibleLessons = try container.decode([String].self, forKey: .accessibleLessons)
        self.hasCompletedDailyRevision = try container.decode(Bool.self, forKey: .hasCompletedDailyRevision)
        self.revisionStreak = try container.decode(Int.self, forKey: .revisionStreak)
        
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(classUUID, forKey: .classUUID)
        try container.encode(points, forKey: .points)
        try container.encode(notesRevising, forKey: .notesRevising)
        try container.encode(accessibleLessons, forKey: .accessibleLessons)
        try container.encode(hasCompletedDailyRevision, forKey: .hasCompletedDailyRevision)
        try container.encode(revisionStreak, forKey: .revisionStreak)
        
        try super.encode(to: encoder)
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
    
//    func getFullName() -> String {
//        return forename + " " + surname
//    }
    
    /// Adds Note to Dictionary by getting its UUID from the Note object
    func addNote(note: Note) {
        let noteUUID = note.UUID
//        notesRevising[noteUUID] = Date()
//        print(notesRevising[noteUUID]!)
        addNote(noteUUID: noteUUID)
    }
    
    /// Adds Note to Dictionary using its UUID
    func addNote(noteUUID: String) {
        if !noteUUID.hasPrefix("NOTE-") {
            print("Error in adding note to \(self)")
            return
        }
        notesRevising[noteUUID] = Date()
        print("\(self) note \(noteUUID) next revision time/date: \(notesRevising[noteUUID]!)")

    }

}
