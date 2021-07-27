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
    
//    var notesToRevise: [Note]!
//    var noteToDisplay: Note!
    
    
    let rc = Revision.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let note = rc.getFirstNote()!
        updateLabels(noteToDisplay: note)
    }
    
    @IBAction func memorisedButtonTapped(_ sender: Any) {
        let noteToDisplay = rc.getFirstNote()!
        
        // set revision date for the currently displayed note
        noteToDisplay.setDateNextRevise()
        
        // save the new note and all cards in its lesson to JSON
        JsonInterface.encodeLessonCardsToJSON(cards: rc.cards, lessonName: "Lesson01")
        
        rc.removeFirstNoteFromRevision()
                        
        if let newNoteToDisplay = rc.getFirstNote() {
            updateLabels(noteToDisplay: newNoteToDisplay)
        } else {
            print("end of revision!")
            
            // Sends back to previous view controller
            _ = navigationController?.popViewController(animated: true)
        }
    }
        
    func updateLabels(noteToDisplay note: Note) {
        translateFrom.text? = note.translateFrom
        translateTo.text? = note.translateTo
    }
    
    
}

