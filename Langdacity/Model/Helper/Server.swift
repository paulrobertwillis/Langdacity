//
//  Server.swift
//  Langdacity
//
//  Created by Paul Willis on 01/08/2021.
//

import Foundation

class Server {
    private(set) var teachers: [String:Teacher]
    private(set) var students: [String:Student]
    private(set) var lessons: [String] // TODO: Make lessons into objects?
    private(set) var classes: [Int:Class]
    
    private static let instance = Server()

    private init() {
        self.teachers = Server.createTeachers()
        self.students = Server.createStudents()
        self.lessons = []
        self.classes = Server.createClasses()
    }
    
    static func getInstance() -> Server {
//        print(instance.teachers)
//        print(instance.students)
//        print(instance.classes)
        
        return instance
    }
    
    
    // temporary functions to generate template data
    private static func createTeachers() -> [String:Teacher] {
        let teacher1 = try! Teacher(title: .Mr, forename: "Adam", surname: "Bell", email: "a.bell@email.com")
        let teacher2 = try! Teacher(title: .Mr, forename: "Bart", surname: "Bell", email: "b.bell@email.com")
        let teacher3 = try! Teacher(title: .Mrs, forename: "Claire", surname: "Bell", email: "c.bell@email.com")
        let teacher4 = try! Teacher(title: .Ms, forename: "Dianne", surname: "Bell", email: "d.bell@email.com")
        let teacher5 = try! Teacher(title: .Miss, forename: "Ellen", surname: "Bell", email: "e.bell@email.com")

        var dictionary: [String:Teacher] = [:]
        
        dictionary[teacher1.UUID] = teacher1
        dictionary[teacher2.UUID] = teacher2
        dictionary[teacher3.UUID] = teacher3
        dictionary[teacher4.UUID] = teacher4
        dictionary[teacher5.UUID] = teacher5
        
        return dictionary
    }
    
    private static func createStudents() -> [String:Student] {
        do {
            let student1 = try Student(forename: "Amanda", surname: "Student", email: "a.student@email.com")
            let student2 = try Student(forename: "Bella", surname: "Student", email: "b.student@email.com")
            let student3 = try Student(forename: "Clara", surname: "Student", email: "c.student@email.com")
            let student4 = try Student(forename: "David", surname: "Student", email: "d.student@email.com")
            let student5 = try Student(forename: "Erin", surname: "Student", email: "e.student@email.com")

        var dictionary: [String:Student] = [:]
        
        dictionary[student1.UUID] = student1
        dictionary[student2.UUID] = student2
        dictionary[student3.UUID] = student3
        dictionary[student4.UUID] = student4
        dictionary[student5.UUID] = student5
        
        return dictionary
            
        }
        catch {
            print("Error in createStudents() method of Server")
        }
        
        return [:]
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
    
    private static func finalInit() {
        
    }
    
    static func validate(email: String) -> User? {
        if validateUserAsTeacher(email: email) != nil {
            let teacher = validateUserAsTeacher(email: email)
            JsonInterface.encodeToJSON(teacher: teacher!)
            return validateUserAsTeacher(email: email)
        }
        
        return nil
        
    }
    
    private static func validateUserAsTeacher(email: String) -> Teacher? {
        for value in Array(Server.getInstance().teachers.values) {
            if email == value.email {
                JsonInterface.encodeToJSON(teacher: value)
                return value
            }
        }
        return nil
    }
    
//    func validateUserAsStudent(email: String) -> Student? {
//        for value in Array(Server.getInstance().students.values) {
//            if email == value.email {
//                return value
//            }
//        }
//        return nil
//    }
}
