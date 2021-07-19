//
//  RevisionController.swift
//  Langdacity
//
//  Created by Paul Willis on 19/07/2021.
//

import UIKit

class RevisionController: NSObject {
    
    var cards: [Card]!
    
    func cardCreator() {
        let card1 = Card(english: "english1", french: "french1")
        let card2 = Card(english: "english2", french: "french2")
        let card3 = Card(english: "english3", french: "french3")
        cards.append(card1)
        cards.append(card2)
        cards.append(card3)

    }

}
