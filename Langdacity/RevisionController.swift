//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import UIKit

class RevisionController: NSObject {
    
    var cards: [Card]!
    
    override init() {
        let card1 = Card(english: "english1", french: "french1")
        let card2 = Card(english: "english2", french: "french2")
        let card3 = Card(english: "english3", french: "french3")
        
        self.cards = [card1, card2, card3]
    }
    
    func getCards() -> [Card] {
        return cards
    }

}
