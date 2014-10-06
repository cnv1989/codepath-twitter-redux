//
//  LoginViewController.swift
//  TwitterRedux
//
//  Created by Nag Varun Chunduru on 10/5/14.
//  Copyright (c) 2014 cnv. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLoginTap(sender: AnyObject) {
        TwitterClient.sharedInstance.login { (account, error) -> Void in
            if (account != nil) {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                NSLog("Error: \(error)")
            }
        }
    }
}
