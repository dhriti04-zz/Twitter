//
//  ComposeNewTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dhriti Chawla on 2/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit


protocol ComposeNewTweetViewControllerDelegate: class{
    func did(post: Tweet)
}

class ComposeNewTweetViewController: UIViewController, UITextViewDelegate {
    
    
    weak var delegate: ComposeNewTweetViewControllerDelegate!
   
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var charsLeft: UILabel!
    @IBOutlet weak var tweetButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print("HUH? ERROR ----------------")
                print (error)
            } else if let user = user {
                //print("Welcome \(user.name)")
                self.userPhoto.af_setImage(withURL: user.profileImage!)
               
            }
        })
        textView.delegate  = self
        
        //self.textView = RSKPlaceholderTextView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 100))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressBackButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    
    }
    
    
    @IBAction func didTapTweet(_ sender: Any) {
        
        print ("should i tweet??? ")
        APIManager.shared.composeTweet(with: textView.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        if (newText.characters.count < characterLimit+1){
             charsLeft.text = "\(characterLimit - newText.characters.count)"
            //print(newText.characters.count)
        }
        else {
            tweetButton.isUserInteractionEnabled = false
            let alertController = UIAlertController(title: "Alert", message: "Character count not in limit!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print ("OK TAPPED")
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                print ("ERROR")
            }
            
        }

        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit

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
