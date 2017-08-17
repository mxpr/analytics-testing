//
//  Analytics.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import Foundation

protocol Analytics {
    func log(screen: String)
    func log(event: String, action: String)
}

class GoogleAnalytics : Analytics {
    
    // MARK: Analytics
    func log(screen: String) {
        // replace with calls to google analytics
    
        // tracker.set(kGAIScreenName, value: name)
        // let builder = GAIDictionaryBuilder.createScreenView()
        // send(builder)
    }
    
    func log(event: String, action: String) {
        // replace with calls to google analytics
    
        // let builder = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: nil, value: nil)
        // send(builder)
    }
}

class ConsoleAnalytics : Analytics {
    
    // MARK: Analytics
    func log(screen: String) {
        print("[analytics] screen view: \(screen)")
    }
    
    func log(event: String, action: String) {
        print("[analytics] event: \(event) - action: \(action)")
    }
}
