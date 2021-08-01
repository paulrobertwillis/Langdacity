//
//  SplashViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 28/07/2021.
//

import UIKit

@IBDesignable
class SplashViewController: UIViewController {

    @IBOutlet var GetStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Server.finalInit()

//        GetStartedButton.layer.cornerRadius = 5
    }
    
}
