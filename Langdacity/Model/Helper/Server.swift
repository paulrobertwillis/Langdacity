//
//  Server.swift
//  Langdacity
//
//  Created by Paul Willis on 01/08/2021.
//

import Foundation

class Server {
    var teachers: [String:Teacher]
    var students: [Int:Student]
    var lessons: [String] // TODO: Make lessons into objects?
    var classes: [Int:Class]
    
    private static let instance = Server()

    private init() {
        self.teachers = Server.createTeachers()
        self.students = Server.createStudents()
        self.lessons = []
        self.classes = Server.createClasses()
    }
    
    static func getInstance() -> Server {
        return instance
    }
    
    // temporary functions to generate template data
    private static func createTeachers() -> [String:Teacher] {
        let teacher1 = try! Teacher(title: .Mr, forename: "Adam", surname: "Bell")
        let teacher2 = try! Teacher(title: .Mr, forename: "Bart", surname: "Bell")
        let teacher3 = try! Teacher(title: .Mrs, forename: "Claire", surname: "Bell")
        let teacher4 = try! Teacher(title: .Ms, forename: "Dianne", surname: "Bell")
        let teacher5 = try! Teacher(title: .Miss, forename: "Ellen", surname: "Bell")

        var dictionary: [String:Teacher] = [:]
        
        dictionary[teacher1.UUID] = teacher1
        dictionary[teacher2.UUID] = teacher2
        dictionary[teacher3.UUID] = teacher3
        dictionary[teacher4.UUID] = teacher4
        dictionary[teacher5.UUID] = teacher5
        
        return dictionary
        
//        let class1 = Class(name: "7Fr1", language: .french)
//
//        let student1 = Student(forename: "Sarah", surname: "Bell", classUUID: class1.UUID)
//        let student2 = Student(forename: "Student2", surname: "Surname", classUUID: class1.UUID)
//        let student3 = Student(forename: "Student3", surname: "Surname", classUUID: class1.UUID)
//        let student4 = Student(forename: "Student4", surname: "Surname", classUUID: class1.UUID)
//        let student5 = Student(forename: "Student5", surname: "Surname", classUUID: class1.UUID)
//
//        class1.students.append(student1)
//        class1.students.append(student2)
//        class1.students.append(student3)
//        class1.students.append(student4)
//        class1.students.append(student5)
    }
    
    private static func createStudents() -> [Int:Student]{
        let student1 = Student(forename: "Sarah", surname: "Bell")
        let student2 = Student(forename: "Student2", surname: "Surname")
        let student3 = Student(forename: "Student3", surname: "Surname")
        let student4 = Student(forename: "Student4", surname: "Surname")
        let student5 = Student(forename: "Student5", surname: "Surname")

        var dictionary: [Int:Student] = [:]
        
        dictionary[student1.UUID] = student1
        dictionary[student2.UUID] = student2
        dictionary[student3.UUID] = student3
        dictionary[student4.UUID] = student4
        dictionary[student5.UUID] = student5
        
        return dictionary
    }
    
    // TODO: Add lessons through this method
    private static func createLessons() {
        
    }
    
    private static func createClasses() -> [Int:Class] {
        let class1 = Class(name: "8Fr1", language: .french)
        let class2 = Class(name: "8Fr2", language: .french)
        let class3 = Class(name: "8Fr3", language: .french)
        let class4 = Class(name: "8Fr4", language: .french)
        let class5 = Class(name: "8Fr5", language: .french)

        var dictionary: [Int:Class] = [:]
        
        dictionary[class1.UUID] = class1
        dictionary[class2.UUID] = class2
        dictionary[class3.UUID] = class3
        dictionary[class4.UUID] = class4
        dictionary[class5.UUID] = class5
        
        return dictionary
    }
    
}
