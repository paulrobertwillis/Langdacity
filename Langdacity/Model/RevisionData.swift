//
//  RevisionData.swift
//  Langdacity
//
//  Created by Paul Willis on 26/07/2021.
//

import Foundation

class RevisionData: AccessNotesProtocol {
    
    static var cards = [Card]()
    static var notesToRevise = [Note]()
    
    init() {
    }
    
    static func initialiseDatabase() {
        if cards.count == 0, notesToRevise.count == 0 {
            let array = jsonInterface.decodeLessonCardsFromJSON()
            if array != nil {
                RevisionData.cards = array!
            }
            RevisionData.notesToRevise = RevisionData.getNotesToRevise()

        } else {
            return
        }
    }
    
    // TODO: call this function whenever the revision button is pressed so that it updates notes array before checking to see if there are any notes to revise
    static func getNotesToRevise() -> [Note] {
        var notes = [Note]()
        let calendar = Calendar.current
        
        if RevisionData.cards.count > 0 {
            for card in RevisionData.cards {
                for note in card.notes {
                    let dateNextRevise = note.dateNextRevise
                    
                    if calendar.isDateInToday(dateNextRevise) {
                        notes.append(note)
                    }
                }
            }
        }
        
        return notes
    }
    
    
    
}
