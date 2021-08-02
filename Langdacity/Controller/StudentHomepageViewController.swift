//
//  ViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class StudentHomepageViewController: UIViewController {
    
    var user: Student?
    
    let revision = Revision.getInstance()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchLessonDataFromServer()
        } catch fetchError.userHasNoLessons {
            print("User has no lessons to revise")
        } catch fetchError.cannotEncodeToStringArray {
            print("Cannot encode Lesson UUIDs to String Array")
        } catch fetchError.cannotFetchLessonsFromServer {
            print("Cannot fetch lessons from server")
        } catch fetchError.cannotDecodeDataFromServer {
            print("Cannot decode data received from server")
        } catch {
            print("Unknown error encountered when fetching lesson data from server")
        }
    }
    
//    case userHasNoLessons
//    case cannotEncodeToStringArray
//    case cannotFetchLessonsFromServer
//    case cannotDecodeDataFromServer

        
    @IBAction func ReviseButtonTapped(_ sender: Any) {
        if revision.notesToRevise.count > 0 {
            // segue to RevisionViewController
            performSegue(withIdentifier: "ReviseTextSegue", sender: self)
        } else {
            // segue to NoNotesToReviseViewController
            performSegue(withIdentifier: "NoNotesToReviseSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviseTextSegue" {
            let nextViewController = segue.destination as! RevisionViewController
            nextViewController.user = user
        }
    }
    
    enum fetchError: Error {
        case userHasNoLessons
        case cannotEncodeToStringArray
        case cannotFetchLessonsFromServer
        case cannotDecodeDataFromServer
    }

    
    func fetchLessonDataFromServer() throws {
        // Fetch permitted lessons from server
                
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
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
        
        guard let lessons = try? decoder.decode([Lesson].self, from: lessonData) else {
            throw fetchError.cannotDecodeDataFromServer
        }
        
        for lesson in lessons {
            JsonInterface.encodeToJsonAndWriteToFile(lesson: lesson)
        }
    }
}
