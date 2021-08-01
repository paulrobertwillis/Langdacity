//
//  LoginViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 28/07/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var UsernameTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    @IBAction func LogInButtonTapped(_ sender: Any) {
        guard UsernameTextField.hasText else { return }
        
        Server.getInstance()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
