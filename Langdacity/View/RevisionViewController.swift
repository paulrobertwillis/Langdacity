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
    
    @IBOutlet var memorised: UIButton!
    
    var notesToRevise: [Note]!
    var noteToDisplay: Note!
    
    let rc = Revision()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteToDisplay = rc.getNextNote()
        
        if noteToDisplay != nil {
            updateLabels()
        }
    }
    
    @IBAction func memorisedButtonTapped(_ sender: Any) {
        changeRevisionDate()
        rc.removeFirstNoteFromRevision()
        
        if rc.getNumNotesToRevise() > 0 {
            noteToDisplay = rc.getNextNote()
            updateLabels()
        } else {
            print("end of revision!")
            // Sends back to previous view controller
                        
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func changeRevisionDate() {
        rc.setNoteRevisionDate(index: 0)
    }
    
    func updateLabels() {
        translateFrom.text? = noteToDisplay.translateFrom
        translateTo.text? = noteToDisplay.translateTo
    }
    
    
}

