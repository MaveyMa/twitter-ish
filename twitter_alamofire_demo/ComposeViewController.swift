//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mavey Ma on 3/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
class ComposeViewController: UIViewController {
  
  @IBOutlet weak var tweetBodyLabel: UITextView!
  @IBOutlet weak var profileImageView: UIImageView!
  var user: User!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tweetBodyLabel.becomeFirstResponder()
    
    APIManager.shared.getCurrentAccount { (user, error) in
      if let  error = error {
        print("Error getting current account: \(error.localizedDescription)")
      } else if let user = user {
        print("Successfully got current account: \n\(String(describing: user.screenName))")
        self.user = user
        self.setUserProfilePic()
      }
    }
  }
  
  func setUserProfilePic() {
    profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    profileImageView.af_setImage(withURL: URL(string: user.getClearProfilePicURLString())!)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onCancel(_ sender: Any) {
    tweetBodyLabel.resignFirstResponder()
    print("Clicked cancel")
    NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
  }
  @IBAction func onTweet(_ sender: Any) {
    tweetBodyLabel.resignFirstResponder()
    print("Clicked Tweet")
    NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
  }
  
}
