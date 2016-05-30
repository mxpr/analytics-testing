//
//  LoginViewModelTests
//  analytics-testingTests
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import XCTest
@testable import analytics_testing

class MockAnalytics : Analytics {
    
    var didLogScreen: ((String)->Void)?
    var didLogEvent: ((event:String, action:String)->Void)?
    
    // MARK: - Analytics
    func log(screen screen: String) {
        didLogScreen?(screen)
    }
    
    func log(event event: String, action: String) {
        didLogEvent?(event: event, action: action)
    }
}

class LoginViewModelTests: XCTestCase {
    
    var mockAnalytics : MockAnalytics!
    var viewModel : LoginViewModel!
    
    override func setUp() {
        super.setUp()
        
        mockAnalytics = MockAnalytics()
        viewModel = LoginViewModel(analytics: mockAnalytics)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Helpers
    
    func verifyScreenViewAnalytics(screen: String, when block:(()->Void), line: UInt = #line, file: StaticString = #file) {
        
        // setup expectations
        let e = expectationWithDescription("screen view analytics should be logged")
        mockAnalytics.didLogScreen = { loggedScreen in
            e.fulfill()
            XCTAssertEqual(loggedScreen, screen, line: line, file: file)
        }
        
        // perform actions
        block()
        
        // wait for expectations
        waitForExpectationsWithTimeout(1) { error in
            if let _ = error {
                XCTFail("Failed to log screen view analytics", line: line, file: file)
            }
        }
    }
    
    func verifyEventAnalytics(event: String, action: String, when block:(()->Void), line: UInt = #line, file: StaticString = #file) {
        
        // setup expectations
        let e = expectationWithDescription("screen view analytics should be logged")
        mockAnalytics.didLogEvent = { loggedEvent, loggedAction in
            e.fulfill()
            XCTAssertEqual(loggedEvent, event, line: line, file: file)
            XCTAssertEqual(loggedAction, action, line: line, file: file)
        }
        
        // perform actions
        block()
        
        // wait for expectations
        waitForExpectationsWithTimeout(1) { error in
            if let _ = error {
                XCTFail("Failed to log event analytics", line: line, file: file)
            }
        }
    }
    
    
    // MARK: - Tests
    
    func testAnalytics() {
        
        verifyScreenViewAnalytics(AnalyticsScreens.Login, when: {
            self.viewModel.wakeup()
        })
        
        verifyEventAnalytics(AnalyticsEvents.Login, action: AnalyticsActions.Tap, when: {
            self.viewModel.login()
        })
        
        verifyEventAnalytics(AnalyticsEvents.SignUp, action: AnalyticsActions.Tap, when: {
            self.viewModel.signup()
        })
    }
    
    
    
}
