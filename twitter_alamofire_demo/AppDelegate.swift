//
//  AppDelegate.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 4/4/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // MARK: Check for logged in user
    if User.current != nil {
      // Load and show the home view controller
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let navigationViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticatedTabBarController")
      self.window?.rootViewController = navigationViewController
    }
    
    // Keep a look out for if user clicked "Logout"
    NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
      print("Logout notification received")
      self.changeViewTo(targetViewController: "LoginViewController")
    }
    
    // Keep a look out for if user clicked "Cancel"
    NotificationCenter.default.addObserver(forName: Notification.Name("didCancel"), object: nil, queue: OperationQueue.main) { (Notification) in
      print("Cancel notification received")
      self.changeViewTo(targetViewController: "AuthenticatedTabBarController")
    }
    
    return true
  }
  
  func changeViewTo(targetViewController: String) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let targetVC = storyboard.instantiateViewController(withIdentifier: targetViewController)
    self.window?.rootViewController = targetVC
  }
  
  // MARK: TODO: Open URL
  // OAuth step 2
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    // Handle urlcallback sent from Twitter
    APIManager.shared.handle(url: url)
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

