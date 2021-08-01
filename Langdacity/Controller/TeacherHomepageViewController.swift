//
//  TeacherViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 28/07/2021.
//

import UIKit

class TeacherHomepageViewController: UIViewController {
    
    @IBOutlet var GreetingLabel: UILabel!
    
    var user: Teacher?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        GreetingLabel.text = "Hey, \(user!.title) \(user!.surname)"
//        user?.classes.sort()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! ClassListTableViewController
        nextViewController.user = user!
    }

}
