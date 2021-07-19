//
//  RevisionViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class RevisionViewController: UIViewController {
    @IBOutlet var translateFrom: UILabel!
    @IBOutlet var translateTo: UILabel!
    
    var card: Card!
    var cardsToRevise: [Card]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        card = Card(english: "hello", french: "bonjour")
        
        let rc = RevisionController()
        cardsToRevise = rc.getCards()
        
        for card in cardsToRevise {
            print(card.english)
        }
        
        translateFrom.text? = cardsToRevise[0].english
        translateTo.text? = cardsToRevise[0].french
        
        print(card.dateNextRevise)
        
    }
    
    func changeRevisionDate() {
        print("button pressed!")
        card.setDateNextRevise()
    }
    
    @IBAction func memorisedButtonTapped(_ sender: Any) {
        changeRevisionDate()
    }
    
    
}
