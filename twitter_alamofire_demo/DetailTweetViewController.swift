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
  
  @IBOutlet weak var replyButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var likeButton: UIButton!
  
  var tweet: Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let tweet = tweet {
      profPicImage.layer.cornerRadius = profPicImage.frame.height/2
      profPicImage.af_setImage(withURL: URL(string: tweet.user.getClearProfilePicURLString())!)
      authorLabel.text = tweet.user.name
      handleLabel.text = "@" + tweet.user.screenName!
      tweetLabel.text = tweet.text
      timeLabel.text = tweet.getDate() + ", " + tweet.getTime()
      retweetCount.text = String(tweet.retweetCount)
      likeCount.text = String(tweet.favoriteCount)
      checkSingularOrPluralLabels()
    }
    
  }
  
  func initButtons() {
    // Return true if your favorited value is true, and false otherwise.
    // The ?? is there just in case your favorited field is nil. If it is nil, then we will just give it a false value just to be safe.
    retweetButton.isSelected = tweet.retweeted
    likeButton.isSelected = tweet.favorited ?? false
    
    if tweet.retweeted {
      setSelectedRetweetGreenIcon()
    }
    if tweet.favorited! {
      setSelectedFavoriteRedIcon()
    }
  }
  
  @IBAction func didTapFavorite(_ sender: Any) {
    // Update the favorite icon and count in local tweet model
    tweet.favorited = !tweet.favorited!
    likeButton.isSelected = tweet.favorited ?? false
    
    if tweet.favorited! {
      setSelectedFavoriteRedIcon()
      tweet.favoriteCount += 1
      // Send a POST request to the POST favorites/create endpoint
      postRequestToFavoritesCreateEndpoint()
      
    } else {
      setNormalUnfavoriteGreyIcon()
      tweet.favoriteCount -= 1
      // Send a POST request to the POST favorites/destroy endpoint
      postRequestToFavoritesDestroyEndpoint()
    }
    // Update cell UI
    refreshTweetDetails()
  }
  
  @IBAction func didTapRetweet(_ sender: Any) {
    // Update the retweet icon and count in local tweet model
    tweet.retweeted = !tweet.retweeted
    retweetButton.isSelected = tweet.retweeted
    
    if tweet.retweeted {
      setSelectedRetweetGreenIcon()
      tweet.retweetCount += 1
      // Send a POST request to the POST statuses/retweet/:id.json endpoint
      postRequestToStatusesRetweetIDEndpoint()
    } else {
      setNormalUnretweetGreyIcon()
      tweet.retweetCount -= 1
      // Send a POST request to the POST statuses/unretweet/:id.json endpoint
      postRequestToStatusesUnretweetIDEndpoint()
    }
    // Update cell UI
    refreshTweetDetails()
  }
  
  func checkSingularOrPluralLabels() {
    if tweet.retweetCount == 1 {
      retweetLabel.text = "Retweet"
    } else {
      retweetLabel.text = "Retweets"
    }
    if tweet.favoriteCount == 1 {
      likeLabel.text = "Like"
    } else {
      likeLabel.text = "Likes"
    }
  }
  
  func refreshTweetDetails() {
    likeCount.text = String(describing: tweet.favoriteCount)
    retweetCount.text = String(describing: tweet.retweetCount)
    checkSingularOrPluralLabels()
  }
  
  //--------------------------------------------------------------------------------//
  // Helper functions for setting icons
  func setSelectedFavoriteRedIcon() {
    let redTapImage = UIImage(named: "favor-icon-red")
    likeButton.setImage(redTapImage, for: UIControlState.selected)
  }
  
  func setSelectedRetweetGreenIcon() {
    let greenTapImage = UIImage(named: "retweet-icon-green")
    retweetButton.setImage(greenTapImage, for: UIControlState.selected)
  }
  
  func setNormalUnfavoriteGreyIcon() {
    let greyTapImage = UIImage(named: "favor-icon")
    likeButton.setImage(greyTapImage, for: UIControlState.normal)
  }
  
  func setNormalUnretweetGreyIcon() {
    let greyTapImage = UIImage(named: "retweet-icon")
    retweetButton.setImage(greyTapImage, for: UIControlState.normal)
  }
  //--------------------------------------------------------------------------------//
  
  
  //--------------------------------------------------------------------------------//
  // Helper functions for sending network requests to Twitter POST endpoints
  func postRequestToFavoritesCreateEndpoint() {
    // Send a POST request to the POST favorites/create endpoint
    APIManager.shared.favorite(tweet!) { (tweet, error) in
      if let  error = error {
        print("Error favoriting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully favorited the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  func postRequestToFavoritesDestroyEndpoint() {
    // Send a POST request to the POST favorites/destroy endpoint
    APIManager.shared.unfavorite(tweet!) { (tweet, error) in
      if let  error = error {
        print("Error unfavoriting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  func postRequestToStatusesRetweetIDEndpoint() {
    // Send a POST request to the POST statuses/retweet/:id.json endpoint
    APIManager.shared.retweet(tweet!) { (tweet, error) in
      if let  error = error {
        print("Error retweeting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully retweeting the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  func postRequestToStatusesUnretweetIDEndpoint() {
    // Send a POST request to the POST statuses/unretweet/:id.json endpoint
    APIManager.shared.unretweet(tweet!) { (tweet, error) in
      if let  error = error {
        print("Error unretweeting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully unretweeting the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
