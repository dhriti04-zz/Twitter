//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
         //   var user: User!
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName!
            dateLabel.text = tweet.createdAtString
            userImage.af_setImage(withURL: tweet.user.profileImage!)
    
        favButton.setTitle(String(tweet.favoriteCount), for: UIControlState.normal )
            
        retweetButton.setTitle(String(tweet.retweetCount), for: UIControlState.normal)
            
            if(tweet.favorited)!{
               self.favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
                
            } else{
            self.favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal) }
            
            if(tweet.retweeted){
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            } else{
             self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal) }
            
            
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
    
    
    @IBAction func didTapToFavorite(_ sender: Any) {
        
        
        if ( tweet?.favorited != true) {
            
            tweet.favoriteCount += 1
            favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            favButton.setTitle(String(describing: tweet.favoriteCount), for: UIControlState.normal )
            tweet.favorited = true
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
        
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
          }
        }
        else {
             print ("---You've already favorited this!? SO UNFAVORITING IT NOWW!!----")
             tweet.favoriteCount -= 1
            
           favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            favButton.setTitle(String(describing: tweet.favoriteCount), for: UIControlState.normal )
            tweet.favorited = false
            
                APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    }
                }
            }
    }
    
    
    @IBAction func didTapToRetweet(_ sender: Any) {
        
        if ( tweet?.retweeted != true) {
            
            tweet.retweetCount += 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            retweetButton.setTitle(String(describing: tweet.retweetCount), for: UIControlState.normal )
            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully retweed the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            print ("---You've already retweeted this!? SO UNRETWEETING IT NOWW!!----")
            tweet.retweetCount -= 1
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            retweetButton.setTitle(String(describing: tweet.retweetCount), for: UIControlState.normal )
            tweet.retweeted = false
            
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
}
