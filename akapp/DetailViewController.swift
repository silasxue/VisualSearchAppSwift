//
//  DetailViewController.swift
//  akapp
//
//  Created by Akshay on 12/3/15.
//  Copyright © 2015 cornell university. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var switchDetail: UISwitch!
    @IBOutlet var dressImage: UIImageView!
    @IBOutlet var detailWebView: UIWebView!
    
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    @IBAction func switchDetailChange(sender: UISwitch) {
        if sender.on
        {
            self.dressImage.frame = CGRectMake(self.dressImage.frame.origin.x,self.dressImage.frame.origin.y, 200, 200);
            let url = NSURL(string:"http://www.google.com")
            let request = NSURLRequest(URL: url!)
            detailWebView.loadRequest(request)
        }
    }
    
    func configureView(count:Int = 0) {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = "\(dressImage.bounds.height) \(count) \(detail.description)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }



}

