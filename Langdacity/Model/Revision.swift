//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import Foundation

class Revision {
    
    private static let instance = Revision()
    
    // TODO: Remove this cards array?
//    private(set) var cards = [Card]()
    private(set) var notesToRevise = [Note]() {
        didSet {
        }
    }
    private var user: Student
            
    weak var timer: Timer?
    
    private init() {
        // TODO: repeat for every lesson to be loaded
        let array = JsonInterface.decodeLessonCardsFromJson(lessonName: "Lesson01")
        if array != nil {
            self.cards = array!
        }
        self.user = JsonInterface.decodeStudentFromJson(studentUUID: "student")!
        
        self.notesToRevise = getNotesToRevise()
        //TODO: remove print statements
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
        
    static func getInstance() -> Revision {
        return instance
    }
        
    func getNotesToRevise() -> [Note] {
        var notes = [Note]()
        let calendar = Calendar.current
                
        // appending separately for learning/relearning and learnt stops learning/relearning cards being immediately readded in the next notes check
        if cards.count > 0 {
            for card in cards {
                for note in card.notes {
                    let dateNextRevise = note.dateNextRevise
                    
                    if note.learningStatus == .learnt && calendar.isDateInToday(dateNextRevise) {
                        //if notes are learnt, append based on day
                        notes.append(note)
                    } else if note.learningStatus == .learning || note.learningStatus == .relearning {
                        // check if time to revise is in the past
                        if dateNextRevise.timeIntervalSinceNow.sign != .plus {
                                notes.append(note)
                        }
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
