//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import Foundation

class Revision {
    
    private static let instance = Revision()
    
    var cards = [Card]()
    private(set) var notesToRevise = [Note]() {
        didSet {
            print("notesToRevise array changed")
            self.cards = JsonInterface.decodeLessonCardsFromJSON(fileName: "Lesson01")!
        }
    }
            
    weak var timer: Timer?
    
    private init() {
        // TODO: repeat for every lesson to be loaded
        let array = JsonInterface.decodeLessonCardsFromJSON(fileName: "Lesson01")
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
        startRevisionUpdateTimer()
    }
    
    private func startRevisionUpdateTimer() {
        stopTimer() // prevents accidental second timer creation
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            print("Checking notes to revise ...")
            let instance = Revision.getInstance()
            instance.notesToRevise = instance.getNotesToRevise()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }

//    deinit {
//        stopTimer()
//    }
        
    static func getInstance() -> Revision {
        return instance
    }
    
    @objc
    func perMinuteUpdate() {
        print("minute!")
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
                    } else if dateNextRevise.timeIntervalSinceNow.sign == .minus {
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
