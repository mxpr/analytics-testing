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
    let item: T
    let occurs: Int
}

class AnalyticsTester {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func verify(count: Int,
                file: StaticString = #file,
                line: UInt = #line) {
        let records = extractAnalytics()
        XCTAssertEqual(records.count, count, file: file, line: line)
    }
    
    func verify(type occurrence: ItemOccurrence<AnalyticsRecordType>,
                file: StaticString = #file,
                line: UInt = #line) {
        let records = extractAnalytics()
        let matchingRecords = records.filter { $0.type.rawValue == occurrence.item.rawValue }
        XCTAssertEqual(matchingRecords.count, occurrence.occurs, file: file, line: line)
    }
    
    func verify(id occurrence: ItemOccurrence<String>,
                file: StaticString = #file,
                line: UInt = #line) {
        let records = extractAnalytics()
        let matchingRecords = records.filter { $0.identifier == occurrence.item }
        XCTAssertEqual(matchingRecords.count, occurrence.occurs, file: file, line: line)
    }
    
    func verify(data occurrence: ItemOccurrence<String>,
                file: StaticString = #file,
                line: UInt = #line) {
        let records = extractAnalytics()
        let matchingRecords = records.filter { $0.data == occurrence.item }
        XCTAssertEqual(matchingRecords.count, occurrence.occurs, file: file, line: line)
    }
    
    func verify(idAndData occurrence: ItemOccurrence<(id: String, data: String)>,
                file: StaticString = #file,
                line: UInt = #line) {
        let records = extractAnalytics()
        let matchingRecords = records.filter { $0.identifier == occurrence.item.id && $0.data == occurrence.item.data }
        XCTAssertEqual(matchingRecords.count, occurrence.occurs, file: file, line: line)
    }
    
    private func extractAnalytics() -> [AnalyticsRecord] {
        let analyticsDebugger = app.otherElements[TestingConstants.AnalyticsDebugger]
        let decoder = JSONAnalyticsCoder()
        return decoder.decode(analyticsDebugger.value as! String)
    }
}
