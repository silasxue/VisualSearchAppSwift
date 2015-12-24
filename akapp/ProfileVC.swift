//
//  ProfileVC.swift
//  akapp
//
//  Created by Akshay on 12/23/15.
//  Copyright © 2015 cornell university. All rights reserved.
//

import Foundation
import Parse
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    @IBAction func deleteUser(sender: UIButton) {
        let alert = UIAlertController(title: "Delete Account !", message: "Note pressing Delete will erase all data", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func emailPassword(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.currentUser()
        usernameLabel.text = user?.username
        emailLabel.text = user?.email
    }
}