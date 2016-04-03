//
//  LoginViewModel.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    let analytics : Analytics
    
    func wakeup() {
        analytics.log(screen: AnalyticsScreens.Login)
    }
    
    func sleep() {
        
    }
    
    func login() {
        analytics.log(event: AnalyticsEvents.Login, action: AnalyticsActions.Tap)
    }
    
    func signup() {
        analytics.log(event: AnalyticsEvents.SignUp, action: AnalyticsActions.Tap)
    }
    
}