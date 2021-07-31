//
//  jsonInterface.swift
//  Langdacity
//
//  Created by Paul Willis on 26/07/2021.
//

import Foundation

class JsonInterface {
    
    static func decodeLessonCardsFromJSON(fileName: String) -> [Card]? {
        guard
            let path = Bundle.main.path(forResource: "Lesson01", ofType: "json"),
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
    
    static func encodeLessonCardsToJSON(cards: [Card], lessonName lesson: String) {
        
        // find URL of lesson
        guard let fileURL = Bundle.main.url(forResource: lesson, withExtension: "json") else { return }
                
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
}
