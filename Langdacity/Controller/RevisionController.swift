//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import UIKit

class RevisionController: NSObject {
    
    var cards: [Card]!
    var cardsToRevise: [Card]
    
    override init() {
        let card1 = Card(english: "english1", french: "french1")
        let card2 = Card(english: "english2", french: "french2")
        let card3 = Card(english: "english3", french: "french3")
        
        self.cards = [card1, card2, card3]
        
        //TODO only allow cards that are due to revise on day
        self.cardsToRevise = [card1, card2, card3]
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

}
