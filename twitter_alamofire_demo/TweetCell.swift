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
           // nameLabel.text = user.name
           // usernameLabel.text = user.screenName!
            dateLabel.text = tweet.createdAtString
       
    
        favButton.setTitle(String(tweet.favoriteCount), for: UIControlState.normal )
            
        retweetButton.setTitle(String(tweet.retweetCount), for: UIControlState.normal)
            
            
            
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
        tweet.favorited = true
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount += 1
                
                self.favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
                self.favButton.setTitle(String(describing: tweet.favoriteCount), for: UIControlState.normal )
                
            }
        }
        
    }
    
    
    @IBAction func didTapToRetweet(_ sender: Any) {
        tweet.retweeted = true
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
             
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                tweet.retweetCount += 1
                
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
                self.retweetButton.setTitle(String(describing: tweet.retweetCount), for: UIControlState.normal )
                
            }
        }
    }
    
    
}
