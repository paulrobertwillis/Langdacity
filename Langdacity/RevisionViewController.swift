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
    @IBOutlet var memorised: UIButton!
    
    var cardsToRevise: [Card]!
    var cardToDisplay: Card!
    
    let rc = RevisionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardToDisplay = rc.getNextCard()
        updateLabels()
        
        print("\(cardToDisplay.toString()): \(cardToDisplay.dateNextRevise)")
        
    }
    
    @IBAction func memorisedButtonTapped(_ sender: Any) {
        changeRevisionDate()
        rc.removeFirstCardFromRevision()
        
        if rc.getNumCardsToRevise() > 0 {
            cardToDisplay = rc.getNextCard()
            updateLabels()
        } else {
            print("end of revision!")
            // Sends back to previous view controller
            
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func changeRevisionDate() {
        print("button pressed!")
        cardToDisplay.setDateNextRevise()
    }
    
    func updateLabels() {
        translateFrom.text? = cardToDisplay.english
        translateTo.text? = cardToDisplay.french
    }
    
    
}

