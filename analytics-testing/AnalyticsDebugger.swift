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
    
    private let encoder: AnalyticsCoder
    init(encoder: AnalyticsCoder) {
        self.encoder = encoder
    }
    
    // MARK: - Analytics
    func log(screen: String) {
        let record = AnalyticsRecord(type: .screen, identifier: screen, data: nil)
        log(record: record)
    }
    
    func log(event: String, action: String) {
        let record = AnalyticsRecord(type: .event, identifier: event, data: action)
        log(record: record)
    }
    
    // MARK: - Private
    private func log(record: AnalyticsRecord) {
        var records = encoder.decode(debugView.accessibilityValue ?? "")
        records.append(record)
        debugView.accessibilityValue = encoder.encode(records)
    }
}
