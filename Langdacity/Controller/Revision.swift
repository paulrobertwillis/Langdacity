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
    
    init() {
        loadNotesFromFile()
        
//        let card1 = Card(english: "english1", french: "french1")
//        let card2 = Card(english: "english2", french: "french2")
//        let card3 = Card(english: "english3", french: "french3")
//
//        self.cards = [card1, card2, card3]
        
        //TODO only allow cards that are due to revise on day
        self.cardsToRevise = cards
        
        
        
    }
    
    func loadNotesFromFile() {
        
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
    
    func getCards() -> [Card] {
        return cards
    }
    
    func getNextCard() -> Card {
        return cardsToRevise[0]
    }
    
    func getCardsToRevise() -> [Card] {
        return cardsToRevise
    }
    
    func getNumCardsToRevise() -> Int {
        return cardsToRevise.count
    }
    
    func removeFirstCardFromRevision() {
        cardsToRevise.remove(at: 0)
    }
    
    func setCardRevisionDate(index: Int) {
        cards[index].setDateNextRevise()
    }

}

extension Array where Element: Equatable {

//Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
