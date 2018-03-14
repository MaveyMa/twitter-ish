//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mavey Ma on 3/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

// This will allow the delegate to perform any actions necessary after a tweet has been posted, such as update it’s UI to display the new Tweet.
protocol ComposeViewControllerDelegate: NSObjectProtocol {
  func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
  @IBOutlet weak var tweetBodyLabel: UITextView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var charCountLabel: UILabel!
  // Set the max character limit
  var characterLimit: Int = 140
  var user: User!
  weak var delegate: ComposeViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tweetBodyLabel.becomeFirstResponder()
    
    tweetBodyLabel.delegate = self
    charCountLabel.text = String(characterLimit)
    setUserProfilePic()
  }
  
  func setUserProfilePic() {
    profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    profileImageView.af_setImage(withURL: URL(string: (User.current?.getClearProfilePicURLString())!)!)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    // Construct what the new text would be if we allowed the user's latest edit
    let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
    
    // TODO: Update Character Count Label
    charCountLabel.text = String(characterLimit - newText.count)
    
    // The new text should be allowed? True/False
    return newText.count < characterLimit
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
    
    APIManager.shared.composeTweet(with: tweetBodyLabel.text) { (tweet, error) in
      if let error = error {
        print("Error composing tweet: \(error.localizedDescription)")
      } else if let tweet = tweet {
        self.delegate?.did(post: tweet)
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
        print("Successfully posted the following Tweet: \n\(tweet.text)")
      }
    }
    
  }
  
  
  
}



