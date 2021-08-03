//
//  ViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class StudentHomepageViewController: UIViewController {
    
    var user: Student?
    var notes: [Note] = []
    var notesToRevise: [Note] = []
    weak var timer: Timer?

    @IBOutlet var GreetingLabel: UILabel!
    
    @IBAction func ReviseButtonTapped(_ sender: Any) {
        if notesToRevise.count > 0 {
            // segue to RevisionViewController
            performSegue(withIdentifier: "ReviseTextSegue", sender: self)
        } else {
            // segue to NoNotesToReviseViewController
            performSegue(withIdentifier: "NoNotesToReviseSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GreetingLabel.text = "Hey, \(user!.forename)"
        
        fetchLessonDataFromServer()
        startRevisionUpdateTimer()
        notesToRevise = updateNotesToRevise()
        
        
    }
    
//    deinit {
//        stopTimer()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviseTextSegue" {
            let nextViewController = segue.destination as! RevisionViewController
//            nextViewController.user = user
            nextViewController.delegate = self
        }
    }
        
    private func startRevisionUpdateTimer() {
        stopTimer() // prevents accidental second timer creation
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            print("Checking notes to revise ...")
            self.notesToRevise = self.updateNotesToRevise()
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
    
    func fetchLessonDataFromServer() {
        enum fetchError: Error {
            case userHasNoLessons
            case cannotEncodeToStringArray
            case cannotFetchLessonsFromServer
            case cannotDecodeDataFromServer
        }
        
        // Fetch permitted lessons from server
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            guard let lessonStrings = user?.accessibleLessons else {
                throw fetchError.userHasNoLessons
            }
            
            guard let jsonData = try? encoder.encode(lessonStrings) else {
                throw fetchError.cannotEncodeToStringArray
            }
            
            // #warning: error is here
            guard let lessonData = Server.fetchLessons(data: jsonData) else {
                throw fetchError.cannotFetchLessonsFromServer
            }
            
            guard let lessonsArray = try? decoder.decode([Lesson].self, from: lessonData) else {
                throw fetchError.cannotDecodeDataFromServer
            }
            
            for lesson in lessonsArray {
                JsonInterface.encodeToJsonAndWriteToFile(lesson: lesson)
//                print(lesson)
                for card in lesson.cards {
//                    print(card)
                    for note in card.notes {
//                        print(note)
                        notes.append(note)
                    }
                }
            }
        } catch fetchError.userHasNoLessons {
            print("Error in \(#function): User has no lessons to revise")
        } catch fetchError.cannotEncodeToStringArray {
            print("Error in \(#function): Cannot encode Lesson UUIDs to String Array")
        } catch fetchError.cannotFetchLessonsFromServer {
            print("Error in \(#function): Cannot fetch lessons from server")
        } catch fetchError.cannotDecodeDataFromServer {
            print("Error in \(#function): Cannot decode data received from server")
        } catch {
            print("Error in \(#function): Unknown error encountered when fetching lesson data from server")
        }
    }
    
    enum StudentHomepageErrors: Error {
        case date(date: Date?)
        case noteNotBeingRevised(noteExpected: Note)
    }
    
    func updateNotesToRevise() -> [Note] {
        var notesArray = [Note]()
        let calendar = Calendar.current

        // appending separately for learning/relearning and learnt stops learning/relearning cards being immediately readded in the next notes check
        do {
            if notes.count == 0 {
                return notesArray
            }
                        
            for note in notes {
                if !user!.notesRevising.keys.contains(note.UUID) {
                    throw StudentHomepageErrors.noteNotBeingRevised(noteExpected: note)
                }
                
                guard let dateNextRevise = user!.notesRevising[note.UUID] else {
                    throw StudentHomepageErrors.date(date: user!.notesRevising[note.UUID])
                }
                
                if note.learningStatus == .learnt && calendar.isDateInToday(dateNextRevise) {
                    //if notes are learnt, append based on day
                    notesArray.append(note)
                } else if note.learningStatus == .learning || note.learningStatus == .relearning {
                    // check if time to revise is in the past
                    if dateNextRevise.timeIntervalSinceNow.sign != .plus {
                            notesArray.append(note)
                    }
                }
            }
        } catch StudentHomepageErrors.noteNotBeingRevised(let noteExpected) {
            print("Error in \(self) method \(#function): Note \(noteExpected) not found in student's revision list")
        } catch StudentHomepageErrors.date(let date) {
            print("Error in \(self) method \(#function): \(String(describing: date))")
        } catch {
            print("Error in \(self) method \(#function): Unknown error")
        }

        return notesArray
    }
    
    enum cardLearningStatus {
        case learning
        case learnt
        case relearning
    }
    
    func getNotesToRevise() -> Int {
        return notesToRevise.count
    }
    
    func getNotesToRevise(cardLearningStatus: cardLearningStatus) -> Int {
        var count = 0
        
        if cardLearningStatus == .learning {
            for note in notesToRevise {
                if note.learningStatus == .learning {
                    count += 1
                }
            }
        } else if cardLearningStatus == .learnt {
            for note in notesToRevise {
                if note.learningStatus == .learnt {
                    count += 1
                }
            }
        } else if cardLearningStatus == .relearning {
            for note in notesToRevise {
                if note.learningStatus == .relearning {
                    count += 1
                }
            }
        }
        
        return count
    }

    func getFirstNote() -> Note? {
        if notesToRevise.count > 0 {
            return notesToRevise[0]
        }
        return nil
    }
    
    func removeFirstNoteFromRevision() {
        if notesToRevise.count > 0 {
            notesToRevise.removeFirst()
        }
    }
}
