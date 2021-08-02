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
    
    let revision = Revision.getInstance()
        
    @IBAction func ReviseButtonTapped(_ sender: Any) {
        if revision.notesToRevise.count > 0 {
            // segue to RevisionViewController
            performSegue(withIdentifier: "ReviseTextSegue", sender: self)
        } else {
            // segue to NoNotesToReviseViewController
            performSegue(withIdentifier: "NoNotesToReviseSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLessonDataFromServer()
//        startRevisionUpdateTimer()
        notesToRevise = getNotesToRevise()

        for note in notes {
            print(note)
        }
        
        
        
//        for noteUUID in user!.notesRevising.keys {
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviseTextSegue" {
            let nextViewController = segue.destination as! RevisionViewController
            nextViewController.user = user
        }
    }
    
    enum StudentHomepageErrors: Error {
        case noteNotBeingRevised(noteOutOfSync: String)
    }
    
//    private func startRevisionUpdateTimer() {
//        stopTimer() // prevents accidental second timer creation
//        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
//            print("Checking notes to revise ...")
//            let instance = Revision.getInstance()
//            instance.notesToRevise = instance.getNotesToRevise()
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//    }
    
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
    
    func getNotesToRevise() -> [Note] {
        var notesArray = [Note]()
        let calendar = Calendar.current

        // appending separately for learning/relearning and learnt stops learning/relearning cards being immediately readded in the next notes check
        do {
            if notes.count == 0 {
                return notesArray
            }
            
            for note in notes {
                guard let dateNextRevise = user!.notesRevising[note.UUID] else {
                    throw StudentHomepageErrors.noteNotBeingRevised(noteOutOfSync: note.UUID)
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
        } catch StudentHomepageErrors.noteNotBeingRevised(let noteOutOfSync) {
            print("Error in \(self) method \(#function): Note \(noteOutOfSync)")
        } catch {
            print("Error in \(self) method \(#function): Unknown error")
        }

        return notesArray
    }

//    func getCards() -> [Card]? {
//        return cards
//    }
//
//    func getFirstNote() -> Note? {
//        if notesToRevise.count > 0 {
//            return notesToRevise[0]
//        }
//        return nil
//    }
//
//    func removeFirstNoteFromRevision() {
//        if notesToRevise.count > 0 {
//            notesToRevise.removeFirst()
//        }
//    }
}
