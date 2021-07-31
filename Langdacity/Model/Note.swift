//
//  Note.swift
//  Langdacity
//
//  Created by Paul Willis on 25/07/2021.
//

import Foundation

class Note: CustomStringConvertible, Codable {
    var description: String { return "Note \(UUID)"}
    
    let translateFrom: String
    let translateTo: String
    var dateNextRevise: Date
    var easeFactor: Int
    var interval: Int
    var learningStatus: status
    var stepsIndex: Int
    var UUID: Int
//    let card: Card
    
    enum status: String, Codable {
        case learning
        case learnt
        case relearning
    }
    
    static var identifierFactory = 0

    private init(parentCard: Card) {
        let newNoteVariables = schedulingDataConstants().newNoteVariables
        
        self.translateFrom = parentCard.english
        self.translateTo = parentCard.french
        self.dateNextRevise = Date(timeIntervalSinceNow: 0)
        self.easeFactor = newNoteVariables.startingEase // calculated from global constant
        self.interval = newNoteVariables.graduatingInterval // calculated from global constant
        self.learningStatus = status.learning
        self.stepsIndex = 0
        self.UUID = Note.createUniqueIdentifier()
//        self.card = parentCard
    }
    
    static func createNote(card: Card, direction: String) -> Note? {
        //TODO: replace hardcoded "toFrench"/"toEnglish" values
        //TODO: replace hardcoded "language" value
        if direction == "toFrench" {
            return Note.init(parentCard: card)
        } else if direction == "toEnglish" {
            return Note.init(parentCard: card)
        } else {
            return nil
        }
    }
    
    static private func createUniqueIdentifier() -> Int {
        Note.identifierFactory += 1
        return Note.identifierFactory
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

