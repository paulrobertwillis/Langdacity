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
        let array = decodeLessonCardsFromJSON()
        if array != nil {
            self.cards = array!
        }
        
        self.notesToRevise = getNotesToRevise()
        
        print(cards)
        
//        if cards != nil {
//            json(from: cards!)
//        }
    }
    
//    func loadCardsFromFile() {
//
//        if let lessonURL = Bundle.main.url(forResource:
//        "Lesson01", withExtension: "txt") {
//            if let lessonContents = try? String(contentsOf: lessonURL) {
//                var lines = lessonContents.components(separatedBy: "\n")
//
//                lines.remove(object: "")
//
//                // TODO Can you use CSV with Swift? Check documentation
//                for line in lines {
//                    let note = line.components(separatedBy: ",")
//
//                    let english = note[0]
//                    let french = note[1]
//
//                    let card = Card(english: english, french: french)
//                    self.cards?.append(card)
//
//                }
//            }
//        }
//    }
    
    func decodeLessonCardsFromJSON() -> [Card]? {
        guard
            let path = Bundle.main.path(forResource: "Lesson01", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        else {
            print("Error: cannot locate JSON file")
            return nil
        }
        
        do {
            print("attempting cards array creation")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let cards: [Card] = try decoder.decode([Card].self, from: data)
            return cards
        } catch {
            // handle error
            print("error in decoding JSON file")
        }
        
        return nil
    }
    
    func encodeLessonCardsToJSON(cards: [Card]) {
        print("attempting to encode ...")
        
//        // convert cards array into data object
//        guard let data = try? JSONSerialization.data(withJSONObject: cards, options: []) else {
//            print("Error: cannot convert cards array to data")
//            return }
//
//        // convert data into JSON string
//        guard let jsonString = String(data: data, encoding: String.Encoding.utf8) else {
//            print("Error: cannot convert to jsonString")
//            return
//        }
        
//        print(jsonString)

//        do {
//            print("attempting JSON creation")
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//        } catch {
//            // handle error
//            print("error in encoding JSON file")
//        }
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func getNotesToRevise() -> [Note] {
        var notes = [Note]()
        let calendar = Calendar.current
        
        if cards != nil {
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
