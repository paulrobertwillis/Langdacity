//
//  Server.swift
//  Langdacity
//
//  Created by Paul Willis on 01/08/2021.
//

import Foundation

class Server {
    var teachers: [String: Teacher]
    var students: [String: Student]
    var lessons: [String] // TODO: Make lessons into objects?
    
    private static let instance = Server()

    private init() {
        self.teachers = [:]
        self.students = [:]
        self.lessons = []
    }
    
    static func getInstance() -> Server {
        return instance
    }
    
    // temporary functions to generate template data
    func createTeachers() {
        
        
        
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
    }
    
    func createStudents() {
        
    }
    
    func createLessons() {
        
    }
    
}
