//
//  LoginTests.swift
//  analytics-testingUITests
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {
    var app : XCUIApplication!
    var analyticsTester : AnalyticsTester!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        analyticsTester = AnalyticsTester(app: app)
        launch(app)
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Helpers
    func launch(app: XCUIApplication) {
        app.launchArguments = ["-ui-testing","YES"]
        app.launch()
    }
    
    
    
    // MARK: - Tests
    func testAnalyticsDebuggerExists() {
        let analyticsDebugger = app.otherElements[TestingConstants.AnalyticsDebugger]
        XCTAssertTrue(analyticsDebugger.exists)
    }
    
    func testAnalytics() {
        
        // verify screen view is logged on load
        analyticsTester.verify(count: 1)
        analyticsTester.verify(type: ItemOccurrence(item:AnalyticsRecordType.Screen, occurs:1))
        analyticsTester.verify(id: ItemOccurrence(item:AnalyticsScreens.Login, occurs:1))
        
        // tap the login button and verify the tap event is logged
        app.buttons[TestingConstants.LoginButton].tap()
        
        analyticsTester.verify(count: 2)
        analyticsTester.verify(type: ItemOccurrence(item:AnalyticsRecordType.Event, occurs:1))
        analyticsTester.verify(idAndData: ItemOccurrence(item:(AnalyticsEvents.Login, AnalyticsActions.Tap), occurs:1))
        
        // tap the sign up button and verify the tap event is logged
        app.buttons[TestingConstants.SignUpButton].tap()
        
        analyticsTester.verify(count: 3)
        analyticsTester.verify(type: ItemOccurrence(item:AnalyticsRecordType.Event, occurs:2))
        analyticsTester.verify(idAndData: ItemOccurrence(item:(AnalyticsEvents.SignUp, AnalyticsActions.Tap), occurs:1))
    }
    
}
