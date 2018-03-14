//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mavey Ma on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var handleLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var tweetCount: UILabel!
  @IBOutlet weak var followingCount: UILabel!
  @IBOutlet weak var followersCount: UILabel!
  
  var user: User!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    user = User.current
    setUpProfile()
  }
  
  func setUpProfile() {
    backdropImageView.af_setImage(withURL: URL(string: user.banner!)!)
    profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    profileImageView.layer.borderWidth = 2
    profileImageView.layer.borderColor = UIColor.white.cgColor
    profileImageView.af_setImage(withURL: URL(string: user.getClearProfilePicURLString())!)
    
    authorLabel.text = user.name
    handleLabel.text = "@" + user.screenName!
    bioLabel.text = user.description
    
    tweetCount.text = String(describing: user.numTweets)
    followingCount.text = String(describing: user.numFollowing)
    followersCount.text = String(describing: user.numFollowers)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func didTapLogout(_ sender: Any) {
    APIManager.shared.logout()
  }
  
}
