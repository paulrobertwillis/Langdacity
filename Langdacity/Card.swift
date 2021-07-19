//
//  Card.swift
//  Langdacity
//
//  Created by Paul Willis on 18/07/2021.
//

import UIKit

class Card: NSObject {
    
    var english: String
    var french: String
    var dateNextRevise: Date
    
    init(english: String, french: String) {
        self.english = english
        self.french = french
        self.dateNextRevise = NSDate() as Date
    }

    func setDateNextRevise() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: dateNextRevise)!
        print(modifiedDate)
        dateNextRevise = modifiedDate
    }
    

}
