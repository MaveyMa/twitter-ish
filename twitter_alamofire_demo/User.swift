//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
  
  var name: String
  var screenName: String?
  var profilePicturePathString: String?
  private static var _current: User?
  var hasDefaultProfileImage: Bool
  var banner: String?
  var description: String?
  var numTweets: Int
  var numFollowing: Int
  var numFollowers: Int
  
  
  
  // For user persistance
  var dictionary: [String: Any]?
  
  init(dictionary: [String: Any]) {
    self.dictionary = dictionary
    name = dictionary["name"] as! String
    screenName = dictionary["screen_name"] as? String
    profilePicturePathString = dictionary["profile_image_url"] as? String
    hasDefaultProfileImage = dictionary["default_profile_image"] as! Bool
    banner = dictionary["profile_banner_url"] as? String
    description = dictionary["description"] as? String
    numTweets = dictionary["statuses_count"] as! Int
    numFollowing = dictionary["friends_count"] as! Int
    numFollowers = dictionary["followers_count"] as! Int
  }
  
  static var current: User? {
    get {
      if _current == nil {
        let defaults = UserDefaults.standard
        if let userData = defaults.data(forKey: "currentUserData") {
          let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
          _current = User(dictionary: dictionary)
        }
      }
      return _current
    }
    set (user) {
      _current = user
      let defaults = UserDefaults.standard
      if let user = user {
        let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
        defaults.set(data, forKey: "currentUserData")
      } else {
        defaults.removeObject(forKey: "currentUserData")
      }
    }
  }
  
  func getClearProfilePicURLString() -> String {
    let profileURLPart1 = String(describing: self.profilePicturePathString!.dropLast(11))
    var profileURLPart2 = ""
    
    if self.hasDefaultProfileImage {
      profileURLPart2 = ".png"
    } else {
      profileURLPart2 = ".jpg"
    }
    
    return profileURLPart1 + profileURLPart2
  }
}
