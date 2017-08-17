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
    
    lazy var debugView: UIView = {
        // view can't has CGRect.zero frame, otherwise it won't get
        // included in the accessibility tree exposed to the UI tests
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.accessibilityIdentifier = TestingConstants.AnalyticsDebugger
        view.accessibilityValue = ""
        return view
    }()
    
    fileprivate let encoder: AnalyticsEncoder
    init(encoder: AnalyticsEncoder) {
        self.encoder = encoder
    }
    
    // MARK: - Analytics
    func log(screen: String) {
        let record = AnalyticsRecord(type: .Screen, identifier: screen, data: nil)
        logRecord(record)
    }
    
    func log(event: String, action: String) {
        let record = AnalyticsRecord(type: .Event, identifier: event, data: action)
        logRecord(record)
    }
    
    // MARK: - Private
    fileprivate func logRecord(_ record: AnalyticsRecord) {
        var records = encoder.decode(debugView.accessibilityValue ?? "")
        records.append(record)
        debugView.accessibilityValue = encoder.encode(records)
    }
}
