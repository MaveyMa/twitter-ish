//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var tweets: [Tweet] = []
  var refreshControl: UIRefreshControl!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
    self.tableView.reloadData()
    get20PostsFromParse()    
  }
  
  @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
    get20PostsFromParse()
  }
  
  func get20PostsFromParse(){
    APIManager.shared.getHomeTimeLine { (tweets, error) in
      if let tweets = tweets {
        self.tweets = tweets
        self.tableView.reloadData()
      } else if let error = error {
        print("Error getting home timeline: " + error.localizedDescription)
      }
    }
    self.refreshControl.endRefreshing()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    
    cell.tweet = tweets[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "TweetDetailSegue" {
      let cell = sender as! UITableViewCell
      if let indexPath = tableView.indexPath(for: cell) {
        let tweet = tweets[indexPath.row]
        let detailViewController = segue.destination as! DetailTweetViewController
        detailViewController.tweet = tweet
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
