//
//  ViewController.swift
//  TwitterRedux
//
//  Created by Nag Varun Chunduru on 10/4/14.
//  Copyright (c) 2014 cnv. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // view controllers
    var profileViewController: ProfileViewController!
    var homeTimelineViewController: HomeTimelineViewController!
    var mentionsViewController: MentionsViewController!
    
    // views
    @IBOutlet weak var menuView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // menu
    let menu = [
        ["type": "profile"],
        ["type": "item", "icon": UIImage(named: "profile8"), "id": "profile", "displayName": "Profile"],
        ["type": "item", "icon": UIImage(named: "dwelling1"), "id": "homeTimeline", "displayName": "Home Timeline"],
        ["type": "item", "icon": UIImage(named: "hash1"), "id": "mentionsTimeline", "displayName": "Mentions Timeline"]
    ]
    
    // menu to viewcontroller map
    var menuToViewControllerMap = Dictionary<NSString, UIViewController>()
    
    
    // active
    var activeViewController: UIViewController? {
        didSet(oldViewControllerorNil) {
            if let oldVC = oldViewControllerorNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.frame = self.containerView.bounds
                self.containerView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.estimatedRowHeight  = 140
        self.menuView.rowHeight = UITableViewAutomaticDimension
        
        self.initializeSubViewControllers();
        NSNotificationCenter.defaultCenter().addObserverForName("ShowUserTimeline", object: nil, queue: nil
            ) { (notification: NSNotification!) -> Void in
                if (notification.object != nil) {
                    var tweet = notification.object as Tweet
                    self.profileViewController.user = tweet.user!
                    self.activeViewController = self.profileViewController
                }
        }
    }
    
    func initializeSubViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
        profileViewController.user = Account.currentAccount?.user
        
        homeTimelineViewController = storyboard.instantiateViewControllerWithIdentifier("HomeTimelineViewController") as HomeTimelineViewController

        mentionsViewController = storyboard.instantiateViewControllerWithIdentifier("MentionsViewController") as MentionsViewController
        
        menuToViewControllerMap.updateValue(profileViewController, forKey: "profile")
        menuToViewControllerMap.updateValue(homeTimelineViewController, forKey: "homeTimeline")
        menuToViewControllerMap.updateValue(mentionsViewController, forKey: "mentionsTimeline")
        
        self.activeViewController = profileViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSwipe(sender: UISwipeGestureRecognizer){
        
        if (sender.direction == .Right && sender.state == .Ended) {
            self.revealMenu()
        }
        if (sender.direction == .Left && sender.state == .Ended) {
            self.hideMenu()
        }
    }
    
    func revealMenu() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerView.frame.origin.x = self.menuView.frame.width
        })
    }
    
    func hideMenu() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerView.frame.origin.x = 0
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuItem = menu[indexPath.row]
        if (menuItem["type"] == "profile") {
            let cell = tableView.dequeueReusableCellWithIdentifier("menu.profile.cell") as ProfileTableViewCell
            cell.configure(Account.currentAccount?.user)
            return cell
        } else if (menuItem["type"] == "item") {
            let cell = tableView.dequeueReusableCellWithIdentifier("menu.item.cell") as MenuItemTableViewCell
            var icon = menuItem["icon"] as UIImage
            var name = menuItem["displayName"] as NSString
            cell.configure(name, icon: icon)
            return cell
        }
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menuItem = menu[indexPath.row]
        profileViewController.user = Account.currentAccount?.user
        if (menuItem["type"] == "item") {
            var id = menuItem["id"] as NSString
            self.activeViewController = menuToViewControllerMap[id] as UIViewController!
        }
    }
}

