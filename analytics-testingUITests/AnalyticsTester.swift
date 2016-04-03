//
//  AnalyticsTester.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import Foundation
import XCTest

struct ItemOccurrence<T> {
    let item : T
    let occurs : Int
}

class AnalyticsTester {
    let app : XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: -
    func extractAnalytics() -> [AnalyticsRecord] {
        let analyticsDebugger = app.otherElements[TestingConstants.AnalyticsDebugger]
        let encoder = JsonAnalyticsEncoder()
        return encoder.decode(analyticsDebugger.value as! String)
    }
    
    func verify(count count: Int,
        line: UInt = __LINE__,
        file: String = __FILE__) {
            let records = extractAnalytics()
            XCTAssertEqual(records.count, count, line: line, file: file)
    }
    
    func verify(type occurrence: ItemOccurrence<AnalyticsRecordType>,
        line: UInt = __LINE__,
        file: String = __FILE__) {
            let records = extractAnalytics()
            let matchingRecords = records.filter{$0.type.rawValue == occurrence.item.rawValue}
            XCTAssertEqual(matchingRecords.count, occurrence.occurs, line: line, file: file)
    }
    
    func verify(id occurrence: ItemOccurrence<String>,
        line: UInt = __LINE__,
        file: String = __FILE__) {
            let records = extractAnalytics()
            let matchingRecords = records.filter{$0.identifier == occurrence.item}
            XCTAssertEqual(matchingRecords.count, occurrence.occurs, line: line, file: file)
    }
    
    func verify(data occurrence: ItemOccurrence<String>,
        line: UInt = __LINE__,
        file: String = __FILE__) {
            let records = extractAnalytics()
            let matchingRecords = records.filter{$0.data == occurrence.item}
            XCTAssertEqual(matchingRecords.count, occurrence.occurs, line: line, file: file)
    }
    
    func verify(idAndData occurrence: ItemOccurrence<(id: String, data: String)>,
        line: UInt = __LINE__,
        file: String = __FILE__) {
            let records = extractAnalytics()
            let matchingRecords = records.filter{ $0.identifier == occurrence.item.id && $0.data == occurrence.item.data}
            XCTAssertEqual(matchingRecords.count, occurrence.occurs, line: line, file: file)
    }
    
}