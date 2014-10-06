//
//  HomeTimelineViewController.swift
//  TwitterRedux
//
//  Created by Nag Varun Chunduru on 10/5/14.
//  Copyright (c) 2014 cnv. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.fetchHomeTimeline()
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
    
    func fetchHomeTimeline() {
        TwitterClient.sharedInstance.fetchHomeTimeline { (tweets, error) -> Void in
            if error == nil {
                self.tweets = tweets!
                dispatch_async(dispatch_get_main_queue(), {
                    self.tweets = tweets!
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var tweet = tweets[indexPath.row]
        NSNotificationCenter.defaultCenter().postNotificationName("ShowUserTimeline", object: tweet)
    }
}
