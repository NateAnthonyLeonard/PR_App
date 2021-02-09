//
//  EncoderFunction.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 8/14/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

//Used to convert an Item to a JSON Dictionary when we upload data to Firestore
// https://stackoverflow.com/questions/45209743/how-can-i-use-swift-s-codable-to-encode-into-a-dictionary 
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
