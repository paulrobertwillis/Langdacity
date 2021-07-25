//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import Foundation

class Revision {
    
    var cards = [Card]()
    var cardsToRevise = [Card]()
    var notesToRevise = [Note]()
    
    init() {
//        loadCardsFromFile()
        self.cards = Card.decodeFromJSON()!
        self.notesToRevise = getNotesToRevise()
    }
    
    func loadCardsFromFile() {
        
        if let lessonURL = Bundle.main.url(forResource:
        "Lesson01", withExtension: "txt") {
            if let lessonContents = try? String(contentsOf: lessonURL) {
                var lines = lessonContents.components(separatedBy: "\n")
                
                lines.remove(object: "")
                
                // TODO Can you use CSV with Swift? Check documentation
                for line in lines {
                    let note = line.components(separatedBy: ",")
                    
                    let english = note[0]
                    let french = note[1]
                    
                    let card = Card(english: english, french: french)
                    self.cards.append(card)
                                
                }
            }
        }
    }
    
    func getNotesToRevise() -> [Note] {
        var notes = [Note]()
        let calendar = Calendar.current
        
        for card in cards {
            for note in card.notes {
                let dateNextRevise = note.dateNextRevise
                
                if calendar.isDateInToday(dateNextRevise) {
                    notes.append(note)
                }
            }
        }
        
        return notes
    }
    
    func getCards() -> [Card] {
        return cards
    }
    
    func getNextNote() -> Note? {
        if notesToRevise.count > 0 {
            return notesToRevise[0]
        }
        return nil
    }
        
    func getNumNotesToRevise() -> Int {
        return notesToRevise.count
    }
    
    func removeFirstNoteFromRevision() {
        notesToRevise.removeFirst()
    }
    
    func setNoteRevisionDate(index: Int) {
        if notesToRevise.count > 0 {
            notesToRevise[index].setDateNextRevise()
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
