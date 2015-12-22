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
    @IBOutlet var msgLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    
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

    
    @IBAction func undoPressed(sender: UIBarButtonItem) {
        self.editorView.lines.popLast()
        self.editorView.setNeedsDisplay()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
//        let alert = UIAlertController(title: "Info \(index)", message: post.comment, preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        presentViewController(alert, animated: true, completion: nil)
        self.editorView.image = image
        stepper.maximumValue = 100;
        stepper.minimumValue = 10;
        stepper.value = 30;
        stepper.stepValue = 10        
        self.editorView.setNeedsDisplay()
    }
    
    @IBAction func sizeChanged(sender: UIStepper) {
        editorView.brushSize = CGFloat(stepper.value)
    }
    
    @IBAction func colorChange(sender: UISwitch) {
        if sender.on{
            msgLabel.text = "Scribble below to highlight regions of interest"
            self.editorView.Green = true
        }
        else{
//            print("off")
            msgLabel.text = "Scribble below to highlight regions to exclude"
            self.editorView.Green = false
        }

    }
    
    @IBAction func clearClicked(sender: UIBarButtonItem) {
        self.editorView.lines = []
        self.editorView.lines.popLast()
        self.editorView.setNeedsDisplay()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let result = segue.destinationViewController as! ResultVC
        result.image = image
        result.post = post
    }
}
