//
//  ConvertFunction.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 8/30/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/**
 Function is used when you want to map an array of objects to an array of dictionaries. This is necessary before uploading objects to firebase
 */
struct ConverterFunctions {
    static func convertToArrayOfMaps(inputArray: [Item]) -> [[String: Any]] {
        var output = [[String: Any]]()
        for x in inputArray {
            try? output.append(x.asDictionary())
        }
        return output
    }
    
    //  Currently Not Used But Can Be Implemented To Create Nested Map On Firebase
    //    static func convertToMapOfMaps(inputArray: [Item]) -> [String: [String: Any]] {
    //        var output = [String: [String: Any]]()
    //        var index = 0
    //        for x in inputArray {
    //            try? output["item \(index)"] = x.asDictionary()
    //            index += 1
    //        }
    //        return output
    //    }
}
/*
class DateAndTimeHelper {
    
    static func convert(timestamp: Double, toDateFormat dateFormat: String) -> String {
        
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: date)
        
    }
    
}
*/

/*
var timestamp: Double = 0.0

// Perform some database querying action in order to retrieve the actual timestamp value from the server
DateAndTimeHelper.convert(timestamp: timestamp, toDateFormat: DATE_FORMAT)
*/
