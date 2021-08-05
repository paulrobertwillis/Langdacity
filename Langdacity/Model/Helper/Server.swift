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
    private(set) static var classes: [String:Class] = createClasses()
    
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
            
//            let card = Card(english: "hi", french: "salut")
//            student1.addNote(note: card.notes[0])
//            student1.addNote(note: card.notes[1])
            
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
    
    private static func createClasses() -> [String:Class] {
        do {
            let class1 = try Class(name: "8Fr1", language: .french)
            let class2 = try Class(name: "8Fr2", language: .french)
            let class3 = try Class(name: "8Fr3", language: .french)
            let class4 = try Class(name: "8Fr4", language: .french)
            let class5 = try Class(name: "8Fr5", language: .french)

            var dictionary: [String:Class] = [:]
            
            dictionary[class1.UUID] = class1
            dictionary[class2.UUID] = class2
            dictionary[class3.UUID] = class3
            dictionary[class4.UUID] = class4
            dictionary[class5.UUID] = class5
            
            return dictionary
            
        } catch {
            print("Error in createClasses() method of Server")
        }
        
        return [:]
    }
    
    static func finalInit() {
        var teacher: Teacher?
        
        for value in Server.teachers.values {
            if value.email == "a.teacher@email.com" {
                teacher = value
            }
        }
        
        var classValues: [String] = []
        for value in Server.classes.keys {
            classValues.append(value)
        }
        classValues.sort()
        teacher?.classes.append(contentsOf: classValues)
    
        var studentValues: [String] = []
        for value in Server.students.keys {
            studentValues.append(value)
        }
        studentValues.sort()
                
        // UUID of class where students should be added
        let targetClassUUID = teacher!.classes[0]
        
        // targetClass where students should be added, taken from Server dictionary of classes using targetClassUUID
//        guard let targetClass = Server.classes[targetClassUUID] else { return }
        
        // for every String in studentValues, add the String to the class's Student list
        for student in studentValues {
            Server.addStudentToClass(student: student, cls: targetClassUUID)
        }
                
//        teacher?.classes[0].students.append(contentsOf: studentValues)
                
        JsonInterface.encodeToJsonAndWriteToFile(teacher: teacher!, shouldPrint: false)
        
        giveStudentLessonAccess(student: "STDT-0001", lesson: "LSSN-0001")
        
    }
    
    static func addStudentToClass(student studentUUID: String, cls classUUID: String) {
        Server.classes[classUUID]?.students.append(studentUUID)
        Server.students[studentUUID]?.classUUID.append(classUUID)
    }
    
    /// Gives a student access to a lesson, taking the student's UUID and the lesson's UUID as parameters. Also adds the lesson's notes to the student's account
    static func giveStudentLessonAccess(student studentUUID: String, lesson lessonUUID: String) {
        guard let student = Server.students[studentUUID] else {
            return
        }
        
        guard let lesson = Server.lessons[lessonUUID] else {
            return
        }
        
        student.accessibleLessons.append(lessonUUID)
        
        for card in lesson.cards {
            for note in card.notes {
                student.notesRevising[note.UUID] = Date()
            }
        }
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
        
        // decoding of data to String array
        guard let array = JsonInterface.decodeNoteArrayFromJsonData(data: data) else { return }
        
        var studentUUID: String
        var noteUUID: String
        var noteDateAsString: String
        
        // separating out String array elements into individual variables
        if array.count == 3 {
            studentUUID = array[0]
            noteUUID = array[1]
            noteDateAsString = array[2]
        } else {
            return
        }
        
        // convert the String representation of the date to a Date object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        guard let noteRevisionDate = dateFormatter.date(from: noteDateAsString) else { return }

        // find student with associated UUID and update the value of the note in their dictionary
        let student = Server.students[studentUUID]
        student?.notesRevising.updateValue(noteRevisionDate, forKey: noteUUID)
    }
        
    /// Fetch data from the server as a Data object
    static func fetchLessons(data: Data) -> Data? {
        enum fetchErrors: Error {
            case cannotDecodeStringArrayFromData
            case cannotEncodeLessonArrayToData
        }
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        do {
            // decode received data to String array
            guard let lessonStrings = try? decoder.decode([String].self, from: data) else {
                throw fetchErrors.cannotDecodeStringArrayFromData
            }
            
            // find all lessons that have UUIDs matching indices of String array
            var lessonArray: [Lesson] = []
            for string in lessonStrings {
                for key in Server.lessons.keys {
                    if key == string {
                        // add those lessons to an array
                        lessonArray.append(Server.lessons[key]!)
                    }
                }
            }
            
            // encode Lesson array to Data
            guard let lessonData = try? encoder.encode(lessonArray) else {
                throw fetchErrors.cannotEncodeLessonArrayToData
            }
            
            // return array
            return lessonData
            
        } catch fetchErrors.cannotDecodeStringArrayFromData {
            print("Error in \(self): cannot decode String array from data")
        } catch fetchErrors.cannotEncodeLessonArrayToData {
            print("Error in \(self): cannot encode Lesson array to data")
        } catch {
            print("Unknown error when fetching lessons")
        }

        return nil
    }
    
    static func fetchStudents(data: Data) -> Data? {
        enum fetchErrors: Error {
            case cannotDecodeStringArrayFromData
            case cannotEncodeStudentArrayToData
        }
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        do {
            // decode received data to String array
            guard let studentStrings = try? decoder.decode([String].self, from: data) else {
                throw fetchErrors.cannotDecodeStringArrayFromData
            }
                        
            // find all students that have UUIDs matching indices of String array
            var studentArray: [Student] = []
            for string in studentStrings {
                for key in Server.students.keys {
                    if key == string {
                        // add those students to an array
                        studentArray.append(Server.students[key]!)
                    }
                }
            }
                        
            // encode Lesson array to Data
            guard let studentData = try? encoder.encode(studentArray) else {
                throw fetchErrors.cannotEncodeStudentArrayToData
            }
            
            // return array as data
            return studentData
            
        } catch fetchErrors.cannotDecodeStringArrayFromData {
            print("Error in \(self): cannot decode String array from data")
        } catch fetchErrors.cannotEncodeStudentArrayToData {
            print("Error in \(self): cannot encode Student array to data")
        } catch {
            print("Unknown error when fetching lessons")
        }

        return nil
    }

    static func fetchClasses(data: Data) -> Data? {
        enum fetchErrors: Error {
            case cannotDecodeStringArrayFromData
            case cannotEncodeClassArrayToData
        }
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        do {
            // decode received data to String array
            guard let classStrings = try? decoder.decode([String].self, from: data) else {
                throw fetchErrors.cannotDecodeStringArrayFromData
            }
            
            // find all students that have UUIDs matching indices of String array
            var classArray: [Class] = []
            for string in classStrings {
                for key in Server.classes.keys {
                    if key == string {
                        // add those students to an array
                        classArray.append(Server.classes[key]!)
                    }
                }
            }
            
            // encode Lesson array to Data
            guard let classData = try? encoder.encode(classArray) else {
                throw fetchErrors.cannotEncodeClassArrayToData
            }
            
            // return array
            return classData
            
        } catch fetchErrors.cannotDecodeStringArrayFromData {
            print("Error in \(self): cannot decode String array from data")
        } catch fetchErrors.cannotEncodeClassArrayToData {
            print("Error in \(self): cannot encode Class array to data")
        } catch {
            print("Unknown error when fetching lessons")
        }

        return nil
    }
    
    static func sendDailyRevisionCompletionData(data: Data) {
        // data contains student UUID as a String and student daily revision completion as a Bool value
        
        // decoding of data to String array
        guard let array = JsonInterface.decodeNoteArrayFromJsonData(data: data) else { return }
                
        // separating out String array elements into individual variables
        if array.count != 2 {
            return
        }
        
        let studentUUID = array[0]
        let hasRevisedAsString = array[1]
        
        // convert the String representation of the Bool to a Bool
        if hasRevisedAsString == "true" {
            Server.students[studentUUID]?.hasCompletedDailyRevision = true
        }
    }
    
    static func sendRevisionStreak(data: Data) {
        // data contains student UUID as a String and student daily revision completion as a Bool value
        
        // decoding of data to String array
        guard let array = JsonInterface.decodeNoteArrayFromJsonData(data: data) else { return }
                
        // separating out String array elements into individual variables
        if array.count != 2 {
            return
        }
        
        let studentUUID = array[0]
        guard let revisionStreak = Int(array[1]) else { return }

        // update student's revision streak
        Server.students[studentUUID]?.revisionStreak = revisionStreak
        
        //#warning there is no method or process to return a student's revision streak to 0 if they do not complete a day's revision
    }
    
    static func sendPoints(data: Data) {
        // data contains student UUID as a String and student points as a String
        
        do {
            // decoding of data to String array
            let decoder = JSONDecoder()
                let array = try decoder.decode([String].self, from: data)
                    
            // separating out String array elements into individual variables
            if array.count != 2 {
                return
            }
            
            let studentUUID = array[0]
            guard let points = Int(array[1]) else { return }

            // update student's points
            Server.students[studentUUID]?.points = points
            
        } catch {
            print("Error in \(self) function \(#function): Unknown error")
        }
    }
    
    static func fetchClassLeaderboard(data: Data) -> Data? {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        do {
            // decode classUUID from data
            let classUUID = try decoder.decode(String.self, from: data)
            
            // use classUUID to find students in the class
            var studentNamesAndPoints: [String:Int] = [:]
            
            if Server.classes[classUUID] != nil {
                for studentUUID in Server.classes[classUUID]!.students {
                    let studentName = Server.students[studentUUID]!.getFullName()
                    let points = Server.students[studentUUID]!.points
                    
                    // add to Dictionary of student names and their current scores
                    studentNamesAndPoints[studentName] = points
                }
            }
            
            // encode Dictionary to Data
            let dataToReturn = try encoder.encode(studentNamesAndPoints)
            
            // return Data
            return dataToReturn
            
        } catch {
            print("Error in \(self) method \(#function): Unknown error")
        }
        
        return nil
    }
    
    func addNewClassToTeacher(data: Data) {
        // TODO: Finish method
    }
    
    func addNewStudentToClassByInvite(data: Data) {
        // TODO: Finish method
    }

}
