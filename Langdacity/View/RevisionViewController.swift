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
        
        //TODO: Set date to revise from current date/time, not from previous revision date
        
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
            noteToDisplay.stepsIndex = 0
            noteToDisplay.setDateNextRevise(minutes: newNote.newSteps[noteToDisplay.stepsIndex])
        case "Good":
            noteToDisplay.stepsIndex += 1
            if (noteToDisplay.stepsIndex) < newNote.newSteps.count {
                noteToDisplay.setDateNextRevise(minutes: newNote.newSteps[noteToDisplay.stepsIndex])
            } else {
                // note graduates from 'learning' to 'learnt'
                noteToDisplay.learningStatus = .learnt
                noteToDisplay.interval = newNote.graduatingInterval
                noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            }
        case "Easy":
            // note graduates from 'learning' to 'learnt'
            noteToDisplay.learningStatus = .learnt
            if noteToDisplay.stepsIndex == 0 {
                noteToDisplay.interval = newNote.graduatingInterval
            } else {
                noteToDisplay.interval = newNote.easyInterval
            }
            noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
        default:
            print("Error")
        }
    }
    
    // Source: code adapted from https://gist.github.com/riceissa/1ead1b9881ffbb48793565ce69d7dbdd
    // Accessed: 2021-07-27
    // Author: riceissa
    func learntNoteScheduler(buttonTitle: String?) {
        let data = schedulingDataConstants()
        let newNote = data.newNoteVariables
        let review = data.reviewVariables

        switch buttonTitle {
        case "Again":
            noteToDisplay.learningStatus = .relearning
            noteToDisplay.stepsIndex = 0
            noteToDisplay.easeFactor = 130 // hardcoded value that resets ease factor as percentage
            noteToDisplay.setDateNextRevise(minutes: newNote.newSteps[noteToDisplay.stepsIndex])
        case "Good":
            noteToDisplay.interval = (noteToDisplay.interval * noteToDisplay.easeFactor/100 * review.intervalModifier/100)
            noteToDisplay.setDateNextRevise(days: min(review.maximumInterval, noteToDisplay.interval)) // enforces maximum interval
        case "Easy":
            noteToDisplay.easeFactor += 15
            noteToDisplay.interval = (noteToDisplay.interval * noteToDisplay.easeFactor/100 * review.intervalModifier/100 * review.easyBonus/100)
            noteToDisplay.setDateNextRevise(days: min(review.maximumInterval, noteToDisplay.interval)) // enforces maximum interval
        default:
            print("Error")
        }
    }
    
    // Source: code adapted from https://gist.github.com/riceissa/1ead1b9881ffbb48793565ce69d7dbdd
    // Accessed: 2021-07-27
    // Author: riceissa
    func relearningNoteScheduler(buttonTitle: String?) {
        let data = schedulingDataConstants()
        let review = data.reviewVariables
        let lapse = data.lapseVariables

        switch buttonTitle {
        case "Again":
            noteToDisplay.stepsIndex = 0
            noteToDisplay.setDateNextRevise(minutes: noteToDisplay.stepsIndex)
        case "Good":
            noteToDisplay.stepsIndex = 0
            if (noteToDisplay.stepsIndex) < lapse.lapseSteps.count {
                noteToDisplay.setDateNextRevise(minutes: lapse.lapseSteps[noteToDisplay.stepsIndex])
            } else {
                // note re-graduates from 'relearning' to 'learnt'
                noteToDisplay.learningStatus = .learnt
                noteToDisplay.interval = max(lapse.minimumInterval, noteToDisplay.interval * lapse.newInterval/100)
                noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            }
        case "Easy":
            // TODO: remove this option and redesign storyboard around it?
            noteToDisplay.stepsIndex = 0
            if (noteToDisplay.stepsIndex) < lapse.lapseSteps.count {
                noteToDisplay.setDateNextRevise(minutes: lapse.lapseSteps[noteToDisplay.stepsIndex])
            } else {
                // note re-graduates from 'relearning' to 'learnt'
                noteToDisplay.learningStatus = .learnt
                noteToDisplay.interval = max(lapse.minimumInterval, noteToDisplay.interval * review.intervalModifier/100)
                noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            }
        default:
            print("Error")
        }
    }
}

