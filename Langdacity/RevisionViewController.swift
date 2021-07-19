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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        card = Card(english: "hello", french: "bonjour")
        
        translateFrom.text? = card.english
        translateTo.text? = card.french
        
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
