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
        tweet.favoriteCount += 1
         
        favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        
        
        favButton.setTitle(String(tweet.favoriteCount), for: UIControlState.normal )
        
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
        
        
    }
    
    
}
