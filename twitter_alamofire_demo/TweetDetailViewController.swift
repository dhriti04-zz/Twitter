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
    @IBOutlet weak var favButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userImage.af_setImage(withURL: (tweet?.user.profileImage)!)
        screenName.text = tweet?.user.name
        userName.text = "@" + (tweet?.user.screenName!)!
        userTweet.text = tweet!.text as String!
        
        favButton.setTitle(String(describing: tweet!.favoriteCount), for: UIControlState.normal )
        
        retweetButton.setTitle(String(describing: tweet!.retweetCount), for: UIControlState.normal)
        
        if(tweet?.favorited)!{
            self.favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            
        } else{
            self.favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal) }
        
        if(tweet?.retweeted)!{
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        } else{
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal) }
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTaptoFavorite(_ sender: Any) {
        
        if ( tweet?.favorited != true) {
            
            tweet?.favoriteCount += 1
            favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            favButton.setTitle(String(describing: tweet!.favoriteCount), for: UIControlState.normal )
            tweet?.favorited = true
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            print ("---You've already favorited this!? SO UNFAVORITING IT NOWW!!----")
            tweet?.favoriteCount -= 1
            
            favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            favButton.setTitle(String(describing: tweet!.favoriteCount), for: UIControlState.normal )
            tweet?.favorited = false
            
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    
    @IBAction func didTaptoRetweet(_ sender: Any) {
        if ( tweet?.retweeted != true) {
            
            tweet?.retweetCount += 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            retweetButton.setTitle(String(describing: tweet!.retweetCount), for: UIControlState.normal )
            tweet?.retweeted = true
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully retweed the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            print ("---You've already retweeted this!? SO UNRETWEETING IT NOWW!!----")
            tweet?.retweetCount -= 1
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            retweetButton.setTitle(String(describing: tweet!.retweetCount), for: UIControlState.normal )
            tweet?.retweeted = false
            
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
        

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let thistweet = tweet {
        let vc = segue.destination as? ReplyViewController
            vc?.tweet = thistweet
        // Pass the selected object to the new view controller.
        }
    }
    
}

