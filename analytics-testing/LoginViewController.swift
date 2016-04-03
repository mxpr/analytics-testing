//
//  LoginViewController.swift
//  analytics-testing
//
//  Created by Kassem Wridan on 03/04/2016.
//  Copyright © 2016 matrixprojects.net. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Dependencies
    var viewModel: LoginViewModel?
    
    // MARK: UIViewController overrides
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.wakeup()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.sleep()
    }

    // MARK: - Actions
    
    @IBAction func didTapLogin(sender: UIButton) {
        viewModel?.login()
    }
    
    @IBAction func didTapSignUp(sender: UIButton) {
        viewModel?.signup()
    }
    
}

