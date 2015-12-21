//
//  EditorController.swift
//  akapp
//
//  Created by Akshay on 12/14/15.
//  Copyright © 2015 cornell university. All rights reserved.
//

import UIKit

class EditorController: UIViewController {

    @IBOutlet var clearBtn: UIBarButtonItem!
    @IBOutlet var editorView: EditorView!
    var index:Int!
    var post:WallPost!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        let alert = UIAlertController(title: "Info \(index)", message: post.comment, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        self.editorView.image = image
    }
    
    
    @IBAction func colorChange(sender: UISwitch) {
        if sender.on{
            self.editorView.Green = true
        }
        else{
            print("off")
            self.editorView.Green = false
        }

    }
    
    @IBAction func clearClicked(sender: UIBarButtonItem) {
        self.editorView.lines = []
        self.editorView.setNeedsDisplay()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
