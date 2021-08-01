//
//  ClassViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import UIKit

class ClassViewController: UIViewController {
    
    var classObj: Class?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! StudentTableViewController
        nextViewController.students = classObj!.students
        
    }
    

}
