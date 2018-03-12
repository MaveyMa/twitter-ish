//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var profilePicImageView: UIImageView!
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var twitterHandleLabel: UILabel!
  @IBOutlet weak var timeStampLabel: UILabel!
  
  @IBOutlet weak var replyCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  
  @IBOutlet weak var replyButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  @IBOutlet weak var tweetTextLabel: UILabel!
  
  var tweet: Tweet! {
    didSet {
      profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height/2
      profilePicImageView.af_setImage(withURL: URL(string: tweet.user.getClearProfilePicURLString())!)
      
      authorNameLabel.text = tweet.user.name
      twitterHandleLabel.text = "@" + tweet.user.screenName!
      timeStampLabel.text = " · " + tweet.createdAtString
      
      replyCountLabel.text = "" //TODO Deprecated. https://www.quora.com/Is-it-possible-to-get-a-count-of-the-replies-and-retweets-for-a-particular-tweet
      retweetCountLabel.text = String(describing: tweet.retweetCount)
      favoriteCountLabel.text = String(describing: tweet.favoriteCount)
      
      initButtons()
      
      tweetTextLabel.text = tweet.text
    }
  }
  
  func initButtons() {
    // Return true if your favorited value is true, and false otherwise.
    // The ?? is there just in case your favorited field is nil. If it is nil, then we will just give it a false value just to be safe.
    retweetButton.isSelected = tweet.retweeted
    favoriteButton.isSelected = tweet.favorited ?? false
    
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
    favoriteButton.isSelected = tweet.favorited ?? false
    
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
    refreshTweetCellUI()
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
    refreshTweetCellUI()
  }
  
  func refreshTweetCellUI() {
    favoriteCountLabel.text = String(describing: tweet.favoriteCount)
    retweetCountLabel.text = String(describing: tweet.retweetCount)
  }
  
  //--------------------------------------------------------------------------------//
  // Helper functions for setting icons
  func setSelectedFavoriteRedIcon() {
    let redTapImage = UIImage(named: "favor-icon-red")
    favoriteButton.setImage(redTapImage, for: UIControlState.selected)
  }
  
  func setSelectedRetweetGreenIcon() {
    let greenTapImage = UIImage(named: "retweet-icon-green")
    retweetButton.setImage(greenTapImage, for: UIControlState.selected)
  }
  
  func setNormalUnfavoriteGreyIcon() {
    let greyTapImage = UIImage(named: "favor-icon")
    favoriteButton.setImage(greyTapImage, for: UIControlState.normal)
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
    APIManager.shared.favorite(tweet) { (tweet, error) in
      if let  error = error {
        print("Error favoriting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully favorited the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  func postRequestToFavoritesDestroyEndpoint() {
    // Send a POST request to the POST favorites/destroy endpoint
    APIManager.shared.unfavorite(tweet) { (tweet, error) in
      if let  error = error {
        print("Error unfavoriting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  func postRequestToStatusesRetweetIDEndpoint() {
    // Send a POST request to the POST statuses/retweet/:id.json endpoint
    APIManager.shared.retweet(tweet) { (tweet, error) in
      if let  error = error {
        print("Error retweeting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully retweeting the following Tweet: \n\(tweet.text)")
      }
    }
  }
  
  func postRequestToStatusesUnretweetIDEndpoint() {
    // Send a POST request to the POST statuses/unretweet/:id.json endpoint
    APIManager.shared.unretweet(tweet) { (tweet, error) in
      if let  error = error {
        print("Error unretweeting tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        print("Successfully unretweeting the following Tweet: \n\(tweet.text)")
      }
    }
  }
  //--------------------------------------------------------------------------------//
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
