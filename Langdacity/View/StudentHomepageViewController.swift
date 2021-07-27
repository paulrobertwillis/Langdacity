//
//  ViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class StudentHomepageViewController: UIViewController {
    
    let revision = Revision.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
        
    @IBAction func ReviseButtonTapped(_ sender: Any) {
        if revision.notesToRevise.count > 0 {
            // segue to RevisionViewController
            performSegue(withIdentifier: "ReviseTextSegue", sender: self)
        } else {
            // segue to NoNotesToReviseViewController
            performSegue(withIdentifier: "NoNotesToReviseSegue", sender: self)
        }
    }
}
