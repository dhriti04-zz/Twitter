//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dhriti Chawla on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    var tweet: Tweet?
    @IBOutlet weak var replyingTo: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    @IBOutlet weak var myReply: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        replyingTo.text = "@" + (tweet?.user.screenName!)!
        
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print("HUH? ERROR ----------------")
                print (error)
            } else if let user = user {
    
                self.myImage.af_setImage(withURL: user.profileImage!)
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedReply(_ sender: Any) {
        APIManager.shared.reply(id: tweet!.idStr, text: myReply.text){ (tweet, error) in
            if let error = error {
                print("Error replying to Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Reply to Tweet Success :) !")
                self.dismiss(animated: true, completion: nil)
            }
        }
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
