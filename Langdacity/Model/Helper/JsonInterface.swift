//
//  jsonInterface.swift
//  Langdacity
//
//  Created by Paul Willis on 26/07/2021.
//

import Foundation

class JsonInterface {
    
    static func decodeLessonCardsFromJSON(lessonName lesson: String) -> [Card]? {
        guard
            let path = Bundle.main.path(forResource: lesson, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        else {
            print("Error: cannot locate JSON file")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let cards: [Card] = try decoder.decode([Card].self, from: data)
            return cards
        } catch {
            // handle error
            print("error in decoding JSON file")
        }
        
        return nil
    }
    
    static func decodeTeacherFromJSON(teacherUUID: String) -> Teacher? {
        guard
            let path = Bundle.main.path(forResource: teacherUUID, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        else {
            print("Error: cannot locate JSON file")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let teacher: Teacher = try decoder.decode(Teacher.self, from: data)
            return teacher
        } catch {
            // handle error
            print("error in decoding JSON file")
        }

        return nil
    }

    
    static func encodeToJSON(cards: [Card], lessonName fileName: String) {
        // find URL of lesson
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
                
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(cards)
            try data.write(to: fileURL)
        } catch {
            // handle error
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    
    static func encodeToJSON(teacher: Teacher, shouldPrint: Bool = false) {
        // find URL of lesson
        guard let fileURL = Bundle.main.url(forResource: teacher.UUID, withExtension: "json")
        else {
            print("Error finding file")
            return }
                
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(teacher)
            if shouldPrint == true {
                data.printJSON()
            }
            try data.write(to: fileURL)
        } catch {
            // handle error
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    
//    static func encodeToJSON(user: User) {
//        // find URL of lesson
//        guard let fileURL = Bundle.main.url(forResource: user.UUID, withExtension: "json")
//        else {
//            print("Error finding file")
//            return }
//
//        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .iso8601
//        encoder.outputFormatting = .prettyPrinted
//
//        do {
//            let data = try encoder.encode(user)
//            data.printJSON()
//            try data.write(to: fileURL)
//        } catch {
//            // handle error
//            print("Failed to write JSON data: \(error.localizedDescription)")
//        }
//    }

}
