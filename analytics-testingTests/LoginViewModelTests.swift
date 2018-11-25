//
//  LoginViewModelTests
//  analytics-testingTests
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import XCTest
@testable import analytics_testing

class MockAnalytics: Analytics {
    var didLogScreen: ((String) -> Void)?
    var didLogEvent: ((_ event: String, _ action: String) -> Void)?
    
    // MARK: - Analytics
    func log(screen: String) {
        didLogScreen?(screen)
    }
    
    func log(event: String, action: String) {
        didLogEvent?(event, action)
    }
}

class LoginViewModelTests: XCTestCase {
    
    var mockAnalytics: MockAnalytics!
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        
        mockAnalytics = MockAnalytics()
        viewModel = LoginViewModel(analytics: mockAnalytics)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testAnalytics() {
        
        verifyAnalytics(screen: AnalyticsScreens.Login, when: {
            viewModel.wakeup()
        })
        
        verifyAnalytics(event: AnalyticsEvents.Login, action: AnalyticsActions.Tap, when: {
            viewModel.login()
        })
        
        verifyAnalytics(event: AnalyticsEvents.SignUp, action: AnalyticsActions.Tap, when: {
            viewModel.signup()
        })
    }
    
    // MARK: - Helpers
    
    func verifyAnalytics(screen: String, when block:(()->Void), line: UInt = #line, file: StaticString = #file) {
        
        // setup expectations
        let e = expectation(description: "screen view analytics should be logged")
        mockAnalytics.didLogScreen = { loggedScreen in
            e.fulfill()
            XCTAssertEqual(loggedScreen, screen, file: file, line: line)
        }
        
        // perform actions
        block()
        
        // wait for expectations
        waitForExpectations(timeout: 1) { error in
            if let _ = error {
                XCTFail("Failed to log screen view analytics", file: file, line: line)
            }
        }
    }
    
    func verifyAnalytics(event: String, action: String, when block:(()->Void), line: UInt = #line, file: StaticString = #file) {
        
        // setup expectations
        let e = expectation(description: "event analytics should be logged")
        mockAnalytics.didLogEvent = { loggedEvent, loggedAction in
            e.fulfill()
            XCTAssertEqual(loggedEvent, event, file: file, line: line)
            XCTAssertEqual(loggedAction, action, file: file, line: line)
        }
        
        // perform actions
        block()
        
        // wait for expectations
        waitForExpectations(timeout: 1) { error in
            if let _ = error {
                XCTFail("Failed to log event analytics", file: file, line: line)
            }
        }
    }
}
