//
//  Server.swift
//  Langdacity
//
//  Created by Paul Willis on 01/08/2021.
//

import Foundation

class Server {
    private(set) static var teachers: [String:Teacher] = createTeachers()
    private(set) static var students: [String:Student] = createStudents()
    private(set) static var lessons: [String:Lesson] = createLessons()
    private(set) static var classes: [Int:Class] = createClasses()
    
    // temporary functions to generate template data
    private static func createTeachers() -> [String:Teacher] {
        let teacher1 = try! Teacher(title: .Mr, forename: "Adam", surname: "Teacher", email: "a.teacher@email.com")
        let teacher2 = try! Teacher(title: .Mr, forename: "Bart", surname: "Teacher", email: "b.teacher@email.com")
        let teacher3 = try! Teacher(title: .Mrs, forename: "Claire", surname: "Teacher", email: "c.teacher@email.com")
        let teacher4 = try! Teacher(title: .Ms, forename: "Dianne", surname: "Teacher", email: "d.teacher@email.com")
        let teacher5 = try! Teacher(title: .Miss, forename: "Ellen", surname: "Teacher", email: "e.teacher@email.com")

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
            
            let card = Card(english: "hi", french: "salut")
            student1.addNote(note: card.notes[0])
            student1.addNote(note: card.notes[1])
            
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
    private static func createLessons() -> [String:Lesson] {
        do {
            let card1 = Card(english: "english1", french: "french1")
            let card2 = Card(english: "english2", french: "french2")
            let card3 = Card(english: "english3", french: "french3")
            let card4 = Card(english: "english4", french: "french4")
            let card5 = Card(english: "english5", french: "french5")
            
            let card6 = Card(english: "english6", french: "french6")
            let card7 = Card(english: "english7", french: "french7")
            let card8 = Card(english: "english8", french: "french8")
            let card9 = Card(english: "english9", french: "french9")
            let card10 = Card(english: "english10", french: "french10")

            let cardArray = [card1, card2, card3, card4, card5]
            let cardArray2 = [card6, card7, card8, card9, card10]
            
            let lesson1 = try Lesson(cards: cardArray)
            let lesson2 = try Lesson(cards: cardArray2)
            
            var dictionary: [String:Lesson] = [:]
            
            dictionary[lesson1.UUID] = lesson1
            dictionary[lesson2.UUID] = lesson2
            
            return dictionary
        }
        catch {
            print("Error in createStudents() method of Server")
        }
        
        return [:]
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
    
    static func finalInit() {
        var teacher: Teacher?
        
        for value in Server.teachers.values {
            if value.email == "a.teacher@email.com" {
                teacher = value
            }
        }
        
        var classValues: [Class] = []
        for value in Server.classes.values {
            classValues.append(value)
        }
        classValues.sort()
        teacher?.classes.append(contentsOf: classValues)
    
        var studentValues: [Student] = []
        for value in Server.students.values {
            studentValues.append(value)
        }
        studentValues.sort()
        teacher?.classes[0].students.append(contentsOf: studentValues)
                
        JsonInterface.encodeToJsonAndWriteToFile(teacher: teacher!, shouldPrint: false)
    }
        
    static func validate(email: String) -> Data? {
        if validateUserAsTeacher(email: email) != nil {
            let teacher = validateUserAsTeacher(email: email)!
            return JsonInterface.encodeToJsonAsData(teacher: teacher)
        } else if validateUserAsStudent(email: email) != nil {
            let student = validateUserAsStudent(email: email)!
            return JsonInterface.encodeToJsonAsData(student: student)
        }
        return nil
    }
    
    private static func validateUserAsTeacher(email: String) -> Teacher? {
        for value in Array(Server.teachers.values) {
            if email == value.email {
                return value
            }
        }
        return nil
    }
    
    private static func validateUserAsStudent(email: String) -> Student? {
        for value in Array(Server.students.values) {
            if email == value.email {
                return value
            }
        }
        return nil
    }
    
    /// Send data to the server as a Data object. Data must be a JSON of a dictionary containing a Student's UUID as a String, and a Note as a Note.
    static func sendNoteData(data: Data) {
        guard let dictionary = JsonInterface.decodeNoteDictionaryFromJsonData(data: data) else { return }
        print(dictionary)
    }
        
    /// Fetch data from the server as a Data object
    static func fetchData() -> Data? {
        return nil
    }
}
