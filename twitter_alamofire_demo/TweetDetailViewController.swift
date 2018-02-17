//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dhriti Chawla on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
