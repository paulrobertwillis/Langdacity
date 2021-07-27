//
//  ViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class StudentHomepageViewController: UIViewController {
    
    let controller = StudentHomepage()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Temp card creation
    }
        
    @IBAction func ReviseButtonTapped(_ sender: Any) {
        if RevisionData.notesToRevise.count > 0 {
            // segue to RevisionViewController
            performSegue(withIdentifier: "ReviseTextSegue", sender: self)
        } else {
            // segue to NoNotesToReviseViewController
            performSegue(withIdentifier: "NoNotesToReviseSegue", sender: self)
        }
        
        
    }
}
