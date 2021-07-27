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
    
    @IBOutlet var difficultyButtons: [UIButton]!
    
    @IBOutlet var difficulty: UIButton!
    
    let rc = Revision.getInstance()
    
    var noteToDisplay: Note {
        rc.getFirstNote()!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let noteToDisplay = rc.getFirstNote()!
        updateLabels()
    }
    
    @IBAction func difficultyButtonTapped(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle
//        let data = schedulingDataConstants()
//        let newCard = data.newCardVariables
//        let review = data.reviewVariables
//        let lapse = data.lapseVariables
        
        if noteToDisplay.learningStatus == .learning {
            // what to do for a new card
            learningNoteScheduler(buttonTitle: buttonTitle)
        
        } else if noteToDisplay.learningStatus == .learnt {
            // what to do for previously learnt card
            learntNoteScheduler(buttonTitle: buttonTitle)
            
        } else if noteToDisplay.learningStatus == .relearning {
            // what to do for card being relearnt
            relearningNoteScheduler(buttonTitle: buttonTitle)
            
        } else {
            print("Error: \(LocalizedError.self)")
        }
                        
        // set revision date for the currently displayed note
//        noteToDisplay.setDateNextRevise()
        
        // save the new note and all cards in its lesson to JSON
        JsonInterface.encodeLessonCardsToJSON(cards: rc.cards, lessonName: "Lesson01")
        
        rc.removeFirstNoteFromRevision()
                        
        if rc.getFirstNote() != nil {
            updateLabels()
        } else {
            print("end of revision!")
            
            // Sends back to previous view controller
            _ = navigationController?.popViewController(animated: true)
        }
    }
        
    func updateLabels() {
        translateFrom.text? = noteToDisplay.translateFrom
        translateTo.text? = noteToDisplay.translateTo
    }
    
    // Source: code adapted from https://gist.github.com/riceissa/1ead1b9881ffbb48793565ce69d7dbdd
    // Accessed: 2021-07-27
    // Author: riceissa
    func learningNoteScheduler(buttonTitle: String?) {
        let data = schedulingDataConstants()
        let newNote = data.newNoteVariables
        
        switch buttonTitle {
        case "Again":
            print("'Again' pressed for learning card")
            noteToDisplay.stepsIndex = 0
            noteToDisplay.setDateNextRevise(minutes: newNote.newSteps[noteToDisplay.stepsIndex])
        case "Good":
            print("'Good' pressed")
            if (noteToDisplay.stepsIndex + 1) < newNote.newSteps.count {
                noteToDisplay.setDateNextRevise(minutes: newNote.newSteps[noteToDisplay.stepsIndex])
            } else {
                // note graduates from 'learning' to 'learnt'
                noteToDisplay.learningStatus = .learnt
                noteToDisplay.interval = newNote.graduatingInterval
                noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            }
        case "Easy":
            print("'Easy' pressed")
            // note graduates from 'learning' to 'learnt'
            noteToDisplay.learningStatus = .learnt
            noteToDisplay.interval = newNote.easyInterval
            noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
        default:
            print("Error")
        }
    }
    
    // Source: code adapted from https://gist.github.com/riceissa/1ead1b9881ffbb48793565ce69d7dbdd
    // Accessed: 2021-07-27
    // Author: riceissa
    func learntNoteScheduler(buttonTitle: String?) {
        switch buttonTitle {
        case "Again":
            print("'Again' pressed")
            
            
        case "Good":
            print("'Good' pressed")
            
            
        case "Easy":
            print("'Easy' pressed")
            
            
        default:
            print("Error")
        }
    }
    
    // Source: code adapted from https://gist.github.com/riceissa/1ead1b9881ffbb48793565ce69d7dbdd
    // Accessed: 2021-07-27
    // Author: riceissa
    func relearningNoteScheduler(buttonTitle: String?) {
        switch buttonTitle {
        case "Again":
            print("'Again' pressed")
            
            
        case "Good":
            print("'Good' pressed")
            
            
        case "Easy":
            print("'Easy' pressed")
            
            
        default:
            print("Error")
        }
    }
    
//    func minutesToDays(minutes: Int) -> Int {
//        return minutes / (60 * 24)
//    }
    
    
}

