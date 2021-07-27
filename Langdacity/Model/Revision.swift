//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import Foundation

class Revision {
    
    private static let instance = Revision()
    
    private(set) var cards = [Card]()
    private(set) var notesToRevise = [Note]()
    
    static func getInstance() -> Revision {
        return instance
    }
    

    private init() {
        let array = JsonInterface.decodeLessonCardsFromJSON()
        if array != nil {
            self.cards = array!
        }
        self.notesToRevise = getNotesToRevise()
        //TODO: remove print statements
        print(cards)
        for card in cards {
            for note in card.notes {
                print(note.description, note.dateNextRevise)
            }
        }
    }
        
    func getNotesToRevise() -> [Note] {
        var notes = [Note]()
        let calendar = Calendar.current
        
        if cards.count > 0 {
            for card in cards {
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
    
    func getCards() -> [Card]? {
        return cards
    }
    
    func getFirstNote() -> Note? {
        if notesToRevise.count > 0 {
            return notesToRevise[0]
        }
        return nil
    }
            
    func removeFirstNoteFromRevision() {
        if notesToRevise.count > 0 {
            notesToRevise.removeFirst()
        }
    }
}

extension Array where Element: Equatable {

//Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
