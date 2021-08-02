//
//  Note.swift
//  Langdacity
//
//  Created by Paul Willis on 25/07/2021.
//

import Foundation

class Note: CustomStringConvertible, Codable {
    var description: String { return UUID }
    
    let translateFrom: String
    let translateTo: String
    var dateNextRevise: Date
    var easeFactor: Int
    var interval: Int
    var learningStatus: status
    var stepsIndex: Int
    var UUID: String
//    let card: Card
    
    enum status: String, Codable {
        case learning
        case learnt
        case relearning
    }
    
    static var identifierFactory = 0

    private init(parentCard: Card) throws {
        let newNoteVariables = schedulingDataConstants().newNoteVariables
        
        self.translateFrom = parentCard.english
        self.translateTo = parentCard.french
        self.dateNextRevise = Date(timeIntervalSinceNow: 0)
        self.easeFactor = newNoteVariables.startingEase // calculated from global constant
        self.interval = newNoteVariables.graduatingInterval // calculated from global constant
        self.learningStatus = status.learning
        self.stepsIndex = 0
        self.UUID = try Note.createUniqueIdentifier(prefix: "NOTE-")
//        self.card = parentCard
    }
    
    static func createNote(card: Card, direction: String) throws -> Note? {
        //TODO: replace hardcoded "toFrench"/"toEnglish" values
        //TODO: replace hardcoded "language" value
        if direction == "toFrench" {
            return try Note.init(parentCard: card)
        } else if direction == "toEnglish" {
            return try Note.init(parentCard: card)
        } else {
            return nil
        }
    }
    
    static private func createUniqueIdentifier(prefix: String) throws -> String {
        Note.identifierFactory += 1
        
//        let prefix = "USER-"
        let id = Note.identifierFactory
        
        guard id >= 1 else {
            throw Errors.uuidErrors.valueTooLow(minValue: 1, actualValue: id)
        }
        
        guard id <= 9999 else {
            throw Errors.uuidErrors.valueTooHigh(maxValue: 9999, actualValue: id)
        }
        
        switch id {
        case 1...9:
            return "\(prefix)0000" + String(id)
        case 10...99:
            return "\(prefix)000" + String(id)
        case 100...999:
            return "\(prefix)00" + String(id)
        case 1000...9999:
            return "\(prefix)0" + String(id)
        case 10000...100_000:
            return "\(prefix)" + String(id)
        default:
            throw Errors.uuidErrors.valueNotInteger(actualValue: String(id))
        }
    }

    func setDateNextRevise(days: Int) {
        let currentDate = Date()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate)!
        setDateNextRevise(modifiedDate)
    }
    
    func setDateNextRevise(minutes: Int) {
        let currentDate = Date()
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minutes, to: currentDate)!
        setDateNextRevise(modifiedDate)
    }
    
    private func setDateNextRevise(_ modifiedDate: Date) {
        let formattedDateNextRevise = dateNextRevise.getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        let formattedModifiedDate = modifiedDate.getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        
        // TODO: Remove this print statement
        print("\(description): \(formattedDateNextRevise) changed to \(formattedModifiedDate)")
        
        self.dateNextRevise = modifiedDate
    }
}

