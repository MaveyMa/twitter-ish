//
//  DetailTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mavey Ma on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
  @IBOutlet weak var profPicImage: UIImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var handleLabel: UILabel!
  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var retweetCount: UILabel!
  @IBOutlet weak var likeCount: UILabel!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var likeLabel: UILabel!
  
  var tweet: Tweet?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let tweet = tweet {
      profPicImage.layer.cornerRadius = profPicImage.frame.height/2
      profPicImage.af_setImage(withURL: URL(string: tweet.user.getClearProfilePicURLString())!)
      authorLabel.text = tweet.user.name
      handleLabel.text = tweet.user.screenName
      tweetLabel.text = tweet.text
      timeLabel.text = tweet.createdAtString
      retweetCount.text = String(tweet.retweetCount)
      if tweet.retweetCount == 1 {
        retweetLabel.text = "Retweet"
      } else {
        retweetLabel.text = "Retweets"
      }
      likeCount.text = String(tweet.favoriteCount)
      if tweet.favoriteCount == 1 {
        likeLabel.text = "Like"
      } else {
        likeLabel.text = "Likes"
      }
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
