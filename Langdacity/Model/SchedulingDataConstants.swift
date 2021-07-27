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
        var newSteps = [5, 60] // in minutes
        var graduatingInterval = 1 // in days
        var easyInterval = 4 // in days
        var startingEase = 2.50 // in percent
    }
    
    struct reviewVariables {
        var easyBonus = 1.30 // in percent
        var intervalModifier = 1.0 // in percent
        var maximumInterval = 365 // in days
    }
    
    struct lapseVariables {
        var lapseSteps = [10] // in minutes
        var newInterval = 0.70 // in percent
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
