//
//  LoginViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 28/07/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    var verifiedUser: User?
        
    @IBOutlet var UsernameTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    @IBAction func LogInButtonTapped(_ sender: Any) {
        guard UsernameTextField.hasText else { return }
        
        guard let user = Server.validate(email: UsernameTextField.text!) else { return }
        
        verifiedUser = user
                
        if user is Teacher {
            performSegue(withIdentifier: "TeacherHomepageSegue", sender: self)
        } else if user is Student {
            performSegue(withIdentifier: "StudentHomepageSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TeacherHomepageSegue" {
            let nextViewController = segue.destination as! TeacherHomepageViewController
            nextViewController.user = verifiedUser as? Teacher
        } else if segue.identifier == "StudentHomepageSegue" {
            let nextViewController = segue.destination as! StudentHomepageViewController
            nextViewController.user = verifiedUser as? Student
        }
    }
}
