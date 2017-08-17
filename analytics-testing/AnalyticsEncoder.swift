//
//  AnalyticsEncoder.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import Foundation

// MARK: - AnalyticsRecord
enum AnalyticsRecordType : String {
    case Screen
    case Event
}

struct AnalyticsRecord : Equatable {
    let type : AnalyticsRecordType
    let identifier : String
    let data : String?
}

func ==(lhs: AnalyticsRecord, rhs: AnalyticsRecord) -> Bool {
    return lhs.type == rhs.type && lhs.identifier == rhs.identifier && lhs.data == rhs.data
}

// MARK: - AnalyticsEncoder

protocol AnalyticsEncoder {
    func encode(_ records: [AnalyticsRecord]) -> String
    func decode(_ string: String) -> [AnalyticsRecord]
}

// MARK: - JsonAnalyticsEncoder

class JsonAnalyticsEncoder : AnalyticsEncoder {
    func encode(_ records: [AnalyticsRecord]) -> String {
        let dictionaryArray = records.map{ $0.dictionary() }
        let jsonData = try! JSONSerialization.data(withJSONObject: dictionaryArray, options: [])
        return String(data: jsonData, encoding: String.Encoding.utf8)!
    }
    
    func decode(_ string: String) -> [AnalyticsRecord] {
        if let jsonData = string.data(using: String.Encoding.utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let dictionaryArray = jsonObject as? [[String:String]] {
                return dictionaryArray.flatMap{ AnalyticsRecord(dictionary: $0) }
        }
        return []
    }
}

// MARK: - AnalyticsRecord + Dictionary

extension AnalyticsRecord {
    
    init?(dictionary: [String : String]) {
        guard let typeString = dictionary["type"],
            let type = AnalyticsRecordType(rawValue: typeString),
            let identifer = dictionary["identifier"] else {
                return nil
        }
        
        self.type = type
        self.identifier = identifer
        self.data = dictionary["data"]
    }
    
    func dictionary() -> [String:String] {
        var dictionary = [String:String]()
        
        dictionary["type"] = type.rawValue
        dictionary["identifier"] = identifier
        if let data = data {
            dictionary["data"] = data
        }
        
        return dictionary
    }
}
