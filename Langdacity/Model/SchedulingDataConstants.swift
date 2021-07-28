//
//  SchedulingDataConstants.swift
//  Langdacity
//
//  Created by Paul Willis on 27/07/2021.
//

import Foundation

class schedulingDataConstants {
    
    let newNoteVariables = newNoteVariables()
    let reviewVariables = reviewVariables()
    let lapseVariables = lapseVariables()
    
    // TODO: incorporate steps into algorithm
    struct newNoteVariables {
        var newSteps = [5, 30] // in minutes
        var graduatingInterval = 1 // in days
        var easyInterval = 3 // in days
        var startingEase = 250 // in percent
    }
    
    struct reviewVariables {
        var easyBonus = 130 // in percent
        var intervalModifier = 100 // in percent
        var maximumInterval = 365 // in days
    }
    
    struct lapseVariables {
        var lapseSteps = [10] // in minutes
        var newInterval = 70 // in percent
        var minimumInterval = 1 // in days
    }
        
//    enum intervals: Int, Codable { // in days
//        case newCardGoodInterval =  1
//        case newCardEasyInterval = 4
//        case lapsedMinimumInterval = 1
//    }
//
//    enum percentageModifiers: Double, Codable {
//        case startingEase = 2.50
//
//    }
    
}
