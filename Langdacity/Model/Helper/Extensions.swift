//
//  Extensions.swift
//  Langdacity
//
//  Created by Paul Willis on 28/07/2021.
//

import Foundation
import UIKit


@IBDesignable extension UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

//@IBDesignable extension UITextField {
//
//    @IBInspectable var cornerRadius: CGFloat {
//        set {
//            layer.cornerRadius = newValue
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


// Source: https://stackoverflow.com/questions/27182023/getting-the-difference-between-two-dates-months-days-hours-minutes-seconds-in
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension Data
{
    /// Prints Data object as a String representation of a JSON object
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}

extension Array where Element: Equatable {

//Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}



//// https://gist.github.com/sukov/d3834c0e7b72e4f7575f753b352f6ddd
//
//private struct JSONCodingKeys: CodingKey {
//    var stringValue: String
//
//    init(stringValue: String) {
//        self.stringValue = stringValue
//    }
//
//    var intValue: Int?
//
//    init?(intValue: Int) {
//        self.init(stringValue: "\(intValue)")
//        self.intValue = intValue
//    }
//}
//
//extension KeyedDecodingContainer {
//    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
//        let container = try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
//        return try container.decode(type)
//    }
//
//    func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
//        var container = try nestedUnkeyedContainer(forKey: key)
//        return try container.decode(type)
//    }
//
//    func decode(_ type: [String: Any].Type) throws -> [String: Any] {
//        var dictionary = [String: Any]()
//
//        for key in allKeys {
//            if let boolValue = try? decode(Bool.self, forKey: key) {
//                dictionary[key.stringValue] = boolValue
//            } else if let intValue = try? decode(Int.self, forKey: key) {
//                dictionary[key.stringValue] = intValue
//            } else if let stringValue = try? decode(String.self, forKey: key) {
//                dictionary[key.stringValue] = stringValue
//            } else if let doubleValue = try? decode(Double.self, forKey: key) {
//                dictionary[key.stringValue] = doubleValue
//            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
//                dictionary[key.stringValue] = nestedDictionary
//            } else if let nestedArray = try? decode([Any].self, forKey: key) {
//                dictionary[key.stringValue] = nestedArray
//            } else if let isValueNil = try? decodeNil(forKey: key), isValueNil == true {
//                dictionary[key.stringValue] = nil
//            } else {
//                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath + [key], debugDescription: "Unable to decode value"))
//            }
//        }
//        return dictionary
//    }
//}
//
//extension UnkeyedDecodingContainer {
//    mutating func decode(_ type: [Any].Type) throws -> [Any] {
//        var array: [Any] = []
//
//        while isAtEnd == false {
//            if let value = try? decode(Bool.self) {
//                array.append(value)
//            } else if let value = try? decode(Int.self) {
//                array.append(value)
//            } else if let value = try? decode(String.self) {
//                array.append(value)
//            } else if let value = try? decode(Double.self) {
//                array.append(value)
//            } else if let nestedDictionary = try? decode([String: Any].self) {
//                array.append(nestedDictionary)
//            } else if let nestedArray = try? decodeNestedArray([Any].self) {
//                array.append(nestedArray)
//            } else if let isValueNil = try? decodeNil(), isValueNil == true {
//                array.append(Optional<Any>.none as Any)
//            } else {
//                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: "Unable to decode value"))
//            }
//        }
//        return array
//    }
//
//    mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
//        let container = try nestedContainer(keyedBy: JSONCodingKeys.self)
//        return try container.decode(type)
//    }
//
//    mutating func decodeNestedArray(_ type: [Any].Type) throws -> [Any] {
//        var container = try nestedUnkeyedContainer()
//        return try container.decode(type)
//    }
//}
//
//
//extension KeyedEncodingContainerProtocol where Key == JSONCodingKeys {
//    mutating func encode(_ value: [String: Any]) throws {
//        for (key, value) in value {
//            let key = JSONCodingKeys(stringValue: key)
//            switch value {
//            case let value as Bool:
//                try encode(value, forKey: key)
//            case let value as Int:
//                try encode(value, forKey: key)
//            case let value as String:
//                try encode(value, forKey: key)
//            case let value as Double:
//                try encode(value, forKey: key)
//            case let value as [String: Any]:
//                try encode(value, forKey: key)
//            case let value as [Any]:
//                try encode(value, forKey: key)
//            case Optional<Any>.none:
//                try encodeNil(forKey: key)
//            default:
//                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + [key], debugDescription: "Invalid JSON value"))
//            }
//        }
//    }
//}
//
//extension KeyedEncodingContainerProtocol {
//    mutating func encode(_ value: [String: Any]?, forKey key: Key) throws {
//        guard let value = value else { return }
//
//        var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
//        try container.encode(value)
//    }
//
//    mutating func encode(_ value: [Any]?, forKey key: Key) throws {
//        guard let value = value else { return }
//
//        var container = nestedUnkeyedContainer(forKey: key)
//        try container.encode(value)
//    }
//}
//
//extension UnkeyedEncodingContainer {
//    mutating func encode(_ value: [Any]) throws {
//        for (index, value) in value.enumerated() {
//            switch value {
//            case let value as Bool:
//                try encode(value)
//            case let value as Int:
//                try encode(value)
//            case let value as String:
//                try encode(value)
//            case let value as Double:
//                try encode(value)
//            case let value as [String: Any]:
//                try encode(value)
//            case let value as [Any]:
//                try encodeNestedArray(value)
//            case Optional<Any>.none:
//                try encodeNil()
//            default:
//                let keys = JSONCodingKeys(intValue: index).map({ [ $0 ] }) ?? []
//                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + keys, debugDescription: "Invalid JSON value"))
//            }
//        }
//    }
//
//    mutating func encode(_ value: [String: Any]) throws {
//        var container = nestedContainer(keyedBy: JSONCodingKeys.self)
//        try container.encode(value)
//    }
//
//    mutating func encodeNestedArray(_ value: [Any]) throws {
//        var container = nestedUnkeyedContainer()
//        try container.encode(value)
//    }
//}

//  CodableExtensions.swift
//  7-Eleven
//
//  Created by Raja Sekhar Chiderae on 1/14/19.
//  Copyright © 2019 self. All rights reserved.

// Inspired by https://gist.github.com/loudmouth/332e8d89d8de2c1eaf81875cfcd22e24
// Used to decode dictionaries and array of dictionaries
struct JSONCodingKeys: CodingKey {
   var stringValue: String
   var intValue: Int?

   init(stringValue: String) {
       self.stringValue = stringValue
   }

   init?(intValue: Int) {
       self.init(stringValue: "\(intValue)")
       self.intValue = intValue
   }
}

extension KeyedDecodingContainer {

   func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
       let container = try self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
       return try container.decode(type)
   }

   func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
       guard contains(key) else {
           return nil
       }
       return try decode(type, forKey: key)
   }

   func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
       var container = try self.nestedUnkeyedContainer(forKey: key)
       return try container.decode(type)
   }

   func decode(_ type: [[String: Any]].Type, forKey key: K) throws -> [[String: Any]] {
       var container = try self.nestedUnkeyedContainer(forKey: key)
       return try container.decode(type)
   }

   func decodeIfPresent(_ type: [Any].Type, forKey key: K) throws -> [Any]? {
       guard contains(key) else {
           return nil
       }
       return try decode(type, forKey: key)
   }

   func decode(_ type: [String: Any].Type) throws -> [String: Any] {
       var dictionary = [String: Any]()

       for key in allKeys {
           if let boolValue = try? decode(Bool.self, forKey: key) {
               dictionary[key.stringValue] = boolValue
           } else if let intValue = try? decode(Int.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(Int8.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(Int16.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(Int32.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(Int64.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(UInt.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(UInt8.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(UInt16.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(UInt32.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let intValue = try? decode(UInt64.self, forKey: key) {
               dictionary[key.stringValue] = intValue
           } else if let doubleValue = try? decode(Float.self, forKey: key) {
               dictionary[key.stringValue] = doubleValue
           } else if let doubleValue = try? decode(Double.self, forKey: key) {
               dictionary[key.stringValue] = doubleValue
           } else if let stringValue = try? decode(String.self, forKey: key) {
               dictionary[key.stringValue] = stringValue
           } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self, forKey: key) {
               dictionary[key.stringValue] = nestedDictionary
           } else if let nestedArray = try? decode(Array<Any>.self, forKey: key) {
               dictionary[key.stringValue] = nestedArray
           } else if let value = try? decodeNil(forKey: key), value {
               //saving NSNull values in a dictionary will produce unexpected results for users, just skip
           }
       }
       return dictionary
   }
   
   func decodeIfPresent<T: Decodable>(forKey key: K, defaultValue: T) -> T {
       do {
           //below will throw
           return try self.decodeIfPresent(T.self, forKey: key) ?? defaultValue
       } catch {
           return defaultValue
       }
   }

}

extension UnkeyedDecodingContainer {

   mutating func decode(_ type: [[String: Any]].Type) throws -> [[String: Any]] {
       var array: [[String: Any]] = []
       while isAtEnd == false {
           if let nestedDictionary = try? decode(Dictionary<String, Any>.self) {
               array.append(nestedDictionary)
           }
       }
       return array
   }

   mutating func decode(_ type: [Any].Type) throws -> [Any] {
       var array: [Any] = []
       while isAtEnd == false {
           if let value = try? decode(Bool.self) {
               array.append(value)
           } else if let value = try? decode(Int.self) {
               array.append(value)
           } else if let value = try? decode(Int8.self) {
               array.append(value)
           } else if let value = try? decode(Int16.self) {
               array.append(value)
           } else if let value = try? decode(Int32.self) {
               array.append(value)
           } else if let value = try? decode(Int64.self) {
               array.append(value)
           } else if let value = try? decode(UInt.self) {
               array.append(value)
           } else if let value = try? decode(UInt16.self) {
               array.append(value)
           } else if let value = try? decode(UInt32.self) {
               array.append(value)
           } else if let value = try? decode(UInt64.self) {
               array.append(value)
           } else if let value = try? decode(Float.self) {
               array.append(value)
           } else if let value = try? decode(Double.self) {
               array.append(value)
           } else if let value = try? decode(String.self) {
               array.append(value)
           } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self) {
               array.append(nestedDictionary)
           } else if let nestedArray = try? decodeNestedArray(Array<Any>.self) {
               array.append(nestedArray)
           } else if let value = try? decodeNil(), value {
               array.append(NSNull()) //unavoidable, but should be fine. We return [Any]. An overload to return homegenous array would be nice.
           } else {
               //if the right type is not found, it will get stuck in an infinite loop, throw, we can't handle it
               throw EncodingError.invalidValue("<UNKNOWN TYPE>", EncodingError.Context(codingPath: codingPath, debugDescription: "<UNKNOWN TYPE>"))
           }
       }
       
       return array
   }
   
   mutating func decodeNestedArray(_ type: [Any].Type) throws -> [Any] {
       // throws: `CocoaError.coderTypeMismatch` if the encountered stored value is not an unkeyed container.
       var nestedContainer = try self.nestedUnkeyedContainer()
       return try nestedContainer.decode(Array<Any>.self)
   }

   mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
       // throws: `CocoaError.coderTypeMismatch` if the encountered stored value is not a keyed container.
       let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
       return try nestedContainer.decode(type)
   }
}

extension KeyedEncodingContainerProtocol where Key == JSONCodingKeys {
   
   mutating func encode(_ value: [String: Any]) throws {
       for (key, value) in value {
           let key = JSONCodingKeys(stringValue: key)
           switch value {
           case let value as Bool:
               try encode(value, forKey: key)
           case let value as Int:
               try encode(value, forKey: key)
           case let value as Int8:
               try encode(value, forKey: key)
           case let value as Int16:
               try encode(value, forKey: key)
           case let value as Int32:
               try encode(value, forKey: key)
           case let value as Int64:
               try encode(value, forKey: key)
           case let value as UInt:
               try encode(value, forKey: key)
           case let value as UInt8:
               try encode(value, forKey: key)
           case let value as UInt16:
               try encode(value, forKey: key)
           case let value as UInt32:
               try encode(value, forKey: key)
           case let value as UInt64:
               try encode(value, forKey: key)
           case let value as Float:
               try encode(value, forKey: key)
           case let value as Double:
               try encode(value, forKey: key)
           case let value as String:
               try encode(value, forKey: key)
           case let value as [String: Any]:
               try encode(value, forKey: key)
           case let value as [Any]:
               try encode(value, forKey: key)
           case is NSNull:
               try encodeNil(forKey: key)
           case Optional<Any>.none:
               try encodeNil(forKey: key)
           default:
               throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + [key], debugDescription: "Invalid JSON value"))
           }
       }
   }
}

extension KeyedEncodingContainerProtocol {
   mutating func encode(_ value: [String: Any]?, forKey key: Key) throws {
       guard let value = value else { return }
       
       var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
       try container.encode(value)
   }
   
   mutating func encode(_ value: [Any]?, forKey key: Key) throws {
       guard let value = value else { return }
       
       var container = nestedUnkeyedContainer(forKey: key)
       try container.encode(value)
   }
}

extension UnkeyedEncodingContainer {
   
   mutating func encode(_ value: [Any]) throws {
       for (index, value) in value.enumerated() {
           switch value {
           case let value as Bool:
               try encode(value)
           case let value as Int:
               try encode(value)
           case let value as Int8:
               try encode(value)
           case let value as Int16:
               try encode(value)
           case let value as Int32:
               try encode(value)
           case let value as Int64:
               try encode(value)
           case let value as UInt:
               try encode(value)
           case let value as UInt8:
               try encode(value)
           case let value as UInt16:
               try encode(value)
           case let value as UInt32:
               try encode(value)
           case let value as UInt64:
               try encode(value)
           case let value as Float:
               try encode(value)
           case let value as Double:
               try encode(value)
           case let value as String:
               try encode(value)
           case let value as [String: Any]:
               try encode(value)
           case let value as [Any]:
               try encodeNestedArray(value)
           case is NSNull:
               try encodeNil()
           case Optional<Any>.none:
               try encodeNil()
           default:
               let keys = JSONCodingKeys(intValue: index).map({ [ $0 ] }) ?? []
               throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + keys, debugDescription: "Invalid JSON value"))
           }
       }
   }
   
   mutating func encode(_ value: [String: Any]) throws {
       var container = nestedContainer(keyedBy: JSONCodingKeys.self)
       try container.encode(value)
   }
   
   mutating func encodeNestedArray(_ value: [Any]) throws {
       var container = nestedUnkeyedContainer()
       try container.encode(value)
   }
}
