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
  @IBOutlet weak var tweetTextLabel: UILabel!
  var tweet: Tweet! {
    didSet {
      tweetTextLabel.text = tweet.text
      favoriteCountLabel.text = String(describing: tweet.favoriteCount)
      retweetCountLabel.text = String(describing: tweet.retweetCount)
      authorNameLabel.text = tweet.user.name
      twitterHandleLabel.text = "@" + tweet.user.screenName!
      timeStampLabel.text = " · " + tweet.createdAtString
      
      profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height/2
      
      profilePicImageView.af_setImage(withURL: URL(string: tweet.user.profilePicturePathString!)!)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
