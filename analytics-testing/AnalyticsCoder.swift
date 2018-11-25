//
//  AnalyticsCoder.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import Foundation

enum AnalyticsRecordType: String, Codable {
    case screen
    case event
}

struct AnalyticsRecord: Codable, Equatable {
    let type: AnalyticsRecordType
    let identifier: String
    let data: String?
}

protocol AnalyticsCoder {
    func encode(_ records: [AnalyticsRecord]) -> String
    func decode(_ string: String) -> [AnalyticsRecord]
}

class JSONAnalyticsCoder: AnalyticsCoder {
    func encode(_ records: [AnalyticsRecord]) -> String {
        let jsonData = try? JSONEncoder().encode(records)
        let jsonString = jsonData.flatMap { String(data: $0, encoding: .utf8) }
        return jsonString ?? ""
    }
    
    func decode(_ string: String) -> [AnalyticsRecord] {
        let data = string.data(using: .utf8)
        let records = data.flatMap { try? JSONDecoder().decode([AnalyticsRecord].self, from: $0) }
        return records ?? []
    }
}
