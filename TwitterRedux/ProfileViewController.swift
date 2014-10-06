
//  ProfileViewController.swift
//  TwitterRedux
//
//  Created by Nag Varun Chunduru on 10/5/14.
//  Copyright (c) 2014 cnv. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: User!
    var tweets: [Tweet] = []
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var bgImage: CustomImageView!
    @IBOutlet weak var userDisplayName: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = 10
        self.profileImage.clipsToBounds = true
        
        self.tweetsCount.layer.cornerRadius = 5
        self.tweetsCount.clipsToBounds = true

        self.followersCount.layer.cornerRadius = 5
        self.followersCount.clipsToBounds = true
        
        self.followingCount.layer.cornerRadius = 5
        self.followingCount.clipsToBounds = true
        
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.profileImage.loadImage(self.user.profile_image_url!)
        self.bgImage.loadImage(self.user.profile_background_image_url!)
        self.userDisplayName.text = self.user.name!
        self.userScreenName.text = "@\(self.user.screen_name!)"
        self.tweetsCount.text = " \(self.getCountText(self.user.statuses_count!)) tweets "
        self.followersCount.text = " \(self.getCountText(self.user.followers_count!)) followers "
        self.followingCount.text = " \(self.getCountText(self.user.friends_count!)) friends "
        
        self.fetchUserTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as TweetTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.configure(tweet)
        return cell
    }
    
    func fetchUserTimeline() {
        TwitterClient.sharedInstance.fetchUserTimeline(user, callback: { (tweets, error) -> Void in
            if error == nil {
                self.tweets = tweets!
                dispatch_async(dispatch_get_main_queue(), {
                    self.tweets = tweets!
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    func getCountText(count: NSInteger) -> String{
        if (count > 1000000) {
            return "\(count/1000000)M"
        }
        if (count > 1000) {
            return "\(count/1000)K"
        }
        return "\(count)"
    }
}
