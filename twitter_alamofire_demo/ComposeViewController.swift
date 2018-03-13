//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mavey Ma on 3/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onCancel(_ sender: Any) {
    //captionTextView.resignFirstResponder()
    print("Clicked cancel")
    NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
  }
  
}
