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
                
        guard let userData = Server.validate(email: UsernameTextField.text!) else { return }
        
        if let user = JsonInterface.decodeTeacherFromJsonData(data: userData) {
            verifiedUser = user
            performSegue(withIdentifier: "TeacherHomepageSegue", sender: self)
        } else if let user = JsonInterface.decodeStudentFromJsonData(data: userData) {
            verifiedUser = user
            JsonInterface.encodeToJsonAndWriteToFile(student: user) // Save Student data to JSON for use by the application. Mimicking it being 'fetched' from server
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
