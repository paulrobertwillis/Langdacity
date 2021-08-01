//
//  Errors.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import Foundation

struct Errors: Error {
    enum uuidErrors: Error {
        case valueTooHigh(maxValue: Int, actualValue: Int)
        case valueTooLow(minValue: Int, actualValue: Int)
        case valueNotInteger(actualValue: String)
    }

    
    // How make this available to all classes??
}
