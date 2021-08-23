//
//  RevisionViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class RevisionViewController: UIViewController {
    
    var user: Student? {
        delegate.user
    }
    
    @IBOutlet var revisionInstructions: UILabel!
    //TODO: update this label when [Notes] array in Revision is updated
    @IBOutlet var notesRemaining: UILabel!
    
    @IBOutlet var translateFrom: UILabel!
    
    @IBOutlet var translateTo: UILabel!
    
    @IBOutlet var difficultyButtons: [UIButton]!
    
    @IBOutlet var difficulty: UIButton!
    
    @IBOutlet var newNotesRemaining: UILabel!
    
    @IBOutlet var previouslySeenNotesRemaining: UILabel!
    
    @IBOutlet var relearningNotesRemaining: UILabel!
    
    @IBAction func tapAction(_ sender: Any) {
        translateTo.isHidden = false
        for UIButton in difficultyButtons {
            UIButton.isHidden = false
        }
    }
    
//    @objc func tapActionInView() {
//        print("we are here")
//        translateTo.isHidden = false
//        for UIButton in difficultyButtons {
//            UIButton.isHidden = false
//        }
//    }
    
    var noteToDisplay: Note {
        delegate.getFirstNote()!
    }
    
    weak var delegate: StudentHomepageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setToHidden()
        updateLabels()
        
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        myView.backgroundColor = .red
//        myView.center = view.center
//        view.addSubview(myView)
//
//        let tapGesture = UITapGestureRecognizer()
//        self.view.addGestureRecognizer(tapGesture)
//        tapGesture.addTarget(self, action: #selector(tapActionInView))
    }
    
//    deinit {
//        delegate.stopTimer()
//    }
    
    func setToHidden() {
        translateTo.isHidden = true
        for UIButton in difficultyButtons {
            UIButton.isHidden = true
        }
    }
    
    @IBAction func difficultyButtonTapped(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle
        
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
//        JsonInterface.encodeToJsonAndWriteToFile(cards: rc.cards, lessonName: "Lesson01")
        
        // TODO: Address issue where lack of Internet connection will cause program to fail
        let dateAsString = noteToDisplay.dateNextRevise.getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
        let array = [user!.UUID, noteToDisplay.UUID, dateAsString]
        guard let data = JsonInterface.encodeToJsonAsData(stringArray: array) else { return }
        Server.sendNoteData(data: data)
        
        delegate.removeFirstNoteFromRevision()
                        
        if delegate.getFirstNote() != nil {
//            noteToDisplay = delegate.getFirstNote()!
            updateLabels()
            setToHidden()
        } else {
            print("end of revision!")
            
            // set student's hasCompletedDailyRevision variable to either true or false
            delegate.checkIfStudentHasCompletedDailyRevision()
            
            // Sends back to previous view controller
            _ = navigationController?.popViewController(animated: true)
        }
    }
        
    func updateLabels() {
        translateFrom.text? = noteToDisplay.translateFrom
        translateTo.text? = noteToDisplay.translateTo
        
        let notes = delegate.getNotesToRevise()
        notesRemaining.text? = "Remaining: \(notes)"
        
        newNotesRemaining.text? = String(delegate.getNotesToRevise(cardLearningStatus: .learning))
        previouslySeenNotesRemaining.text? = String(delegate.getNotesToRevise(cardLearningStatus: .learnt))
        relearningNotesRemaining.text? = String(delegate.getNotesToRevise(cardLearningStatus: .relearning))
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
        case "Hard":
            noteToDisplay.stepsIndex += 1
            if (noteToDisplay.stepsIndex) < newNote.newSteps.count {
                noteToDisplay.setDateNextRevise(minutes: newNote.newSteps[noteToDisplay.stepsIndex])
            } else {
                // note graduates from 'learning' to 'learnt'
                noteToDisplay.learningStatus = .learnt
                noteToDisplay.interval = newNote.graduatingInterval
                noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            }
            user?.points += 1
        case "Easy":
            // note graduates from 'learning' to 'learnt'
            noteToDisplay.learningStatus = .learnt
            if noteToDisplay.stepsIndex == 0 {
                noteToDisplay.interval = newNote.graduatingInterval
            } else {
                noteToDisplay.interval = newNote.easyInterval
            }
            noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            user?.points += 1
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
        case "Hard":
            noteToDisplay.interval = (noteToDisplay.interval * noteToDisplay.easeFactor/100 * review.intervalModifier/100)
            noteToDisplay.setDateNextRevise(days: min(review.maximumInterval, noteToDisplay.interval)) // enforces maximum interval
            user?.points += noteToDisplay.interval
        case "Easy":
            noteToDisplay.easeFactor += 15
            noteToDisplay.interval = (noteToDisplay.interval * noteToDisplay.easeFactor/100 * review.intervalModifier/100 * review.easyBonus/100)
            noteToDisplay.setDateNextRevise(days: min(review.maximumInterval, noteToDisplay.interval)) // enforces maximum interval
            user?.points += noteToDisplay.interval
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
        case "Hard":
            noteToDisplay.stepsIndex += 1
            if (noteToDisplay.stepsIndex) < lapse.lapseSteps.count {
                noteToDisplay.setDateNextRevise(minutes: lapse.lapseSteps[noteToDisplay.stepsIndex])
            } else {
                // note re-graduates from 'relearning' to 'learnt'
                noteToDisplay.learningStatus = .learnt
                noteToDisplay.interval = lapse.minimumInterval
                noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            }
            user?.points += noteToDisplay.interval
        case "Easy":
            // TODO: remove this option and redesign storyboard around it?
            noteToDisplay.learningStatus = .learnt
            noteToDisplay.interval = max(lapse.minimumInterval, noteToDisplay.interval * review.intervalModifier/100)
            noteToDisplay.setDateNextRevise(days: noteToDisplay.interval)
            user?.points += noteToDisplay.interval
        default:
            print("Error")
        }
    }
}

