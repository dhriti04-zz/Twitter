//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dhriti Chawla on 2/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

   
    
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var ScreenName: UILabel!
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    var currUser: User! {
        didSet {
            Username.text = currUser.name
            ScreenName.text = "@" + currUser.screenName!
            userPhoto.af_setImage(withURL: currUser.profileImage!)
        }
    }
    
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
