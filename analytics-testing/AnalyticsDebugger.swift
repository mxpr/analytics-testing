//
//  AnalyticsDebugger.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import Foundation
import UIKit

class AnalyticsDebugger: Analytics {
    
    lazy var debugView : UIView = {
        let view = UIView()
        view.accessibilityIdentifier = TestingConstants.AnalyticsDebugger
        view.accessibilityValue = ""
        return view
    }()
    
    private let encoder : AnalyticsEncoder
    init(encoder: AnalyticsEncoder) {
        self.encoder = encoder
    }
    
    // MARK: - Analytics
    func log(screen screen: String) {
        let record = AnalyticsRecord(type: .Screen, identifier: screen, data: nil)
        logRecord(record)
    }
    
    func log(event event: String, action: String) {
        let record = AnalyticsRecord(type: .Event, identifier: event, data: action)
        logRecord(record)
    }
    
    // MARK: - Private
    private func logRecord(record: AnalyticsRecord) {
        var records = encoder.decode(debugView.accessibilityValue ?? "")
        records.append(record)
        debugView.accessibilityValue = encoder.encode(records)
    }
}