//
//  ViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class StudentHomepageViewController: UIViewController {
    
    var user: Student?
    
    let revision = Revision.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JsonInterface.encodeToJsonAndWriteToFile(student: user!)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviseTextSegue" {
            let nextViewController = segue.destination as! RevisionViewController
            nextViewController.user = user
        }
    }
}
