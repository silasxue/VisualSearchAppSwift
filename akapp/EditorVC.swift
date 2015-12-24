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
    @IBOutlet var imageView: UIImageView!

    var index:Int!
    var post:WallPost!
    var image:UIImage!
    var brushSizeKey = "BrushSize"
    
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
        self.editorView.points.popLast()
        self.editorView.setNeedsDisplay()
    }
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        stepper.maximumValue = 100
        stepper.minimumValue = 10
        stepper.stepValue = 5
        let bsize = NSUserDefaults.standardUserDefaults().doubleForKey(brushSizeKey);
        if bsize == 0 {
            stepper.value = 30;
            NSUserDefaults.standardUserDefaults().setDouble(stepper.value, forKey: brushSizeKey)
        }
        else{
            stepper.value = bsize
        }
        self.editorView.brushSize = CGFloat(stepper.value)
        self.editorView.image = image
        self.imageView.image = image
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit;
        self.editorView.setNeedsDisplay()
    }
    
    @IBAction func sizeChanged(sender: UIStepper) {
        editorView.brushSize = CGFloat(stepper.value)
        NSUserDefaults.standardUserDefaults().setDouble(stepper.value, forKey: brushSizeKey)
    }
    
    @IBAction func colorChange(sender: UISwitch) {
        if sender.on{
            msgLabel.text = "Highlight regions of interest"
            self.editorView.Green = true
            msgLabel.textColor = UIColor.blackColor()
        }
        else{
            msgLabel.text = "Highlight regions to exclude"
            self.editorView.Green = false
            msgLabel.textColor = UIColor.redColor()
        }

    }
    
    @IBAction func clearClicked(sender: UIBarButtonItem) {
        self.editorView.lines = []
        self.editorView.points = []
        self.editorView.setNeedsDisplay()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let result = segue.destinationViewController as! ResultVC
        result.image = image
        result.post = post
    }
}
