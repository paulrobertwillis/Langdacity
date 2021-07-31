//
//  TeacherViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 28/07/2021.
//

import UIKit

class TeacherHomepageViewController: UIViewController {
    
//    var teacher: Teacher {
//        JsonInterface
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let class1 = Class(name: "7Fr1", language: .french)

        let student1 = Student(forename: "Sarah", surname: "Bell", classUUID: class1.UUID)
        let student2 = Student(forename: "Student2", surname: "Surname", classUUID: class1.UUID)
        let student3 = Student(forename: "Student3", surname: "Surname", classUUID: class1.UUID)
        let student4 = Student(forename: "Student4", surname: "Surname", classUUID: class1.UUID)
        let student5 = Student(forename: "Student5", surname: "Surname", classUUID: class1.UUID)
        
        class1.students.append(student1)
        class1.students.append(student2)
        class1.students.append(student3)
        class1.students.append(student4)
        class1.students.append(student5)
        
        var teacher: Teacher?
        
        
        // Creating a Teacher object that can be used to represent the server sending a new JSON to the app
        if let loggedInTeacher = try? Teacher(title: "Mr", forename: "Adam", surname: "Smith", classes: [class1]) {
            JsonInterface.encodeToJSON(teacher: loggedInTeacher)
            
            // Setting the Teacher object that is logged in to the loggedInTeacher constant that has been 'sent' from the server
            teacher = JsonInterface.decodeTeacherFromJSON(teacherUUID: loggedInTeacher.UUID)
        }
        
    }
    

}
