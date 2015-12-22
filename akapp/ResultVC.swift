//
//  SwViewController.swift
//  CVOpenStitch
//
//  Created by Foundry on 04/06/2014.
//  Copyright (c) 2014 Foundry. All rights reserved.
//

import UIKit

class ResultVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var spinner:UIActivityIndicatorView!
    @IBOutlet var imageView:UIImageView?
    @IBOutlet var scrollView: UIScrollView!
    var image:UIImage!
    var post:WallPost!
    var stiched = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        stitch()
    }
    
    
    func stitch() {
        self.spinner.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        var imageArray:[UIImage!] = []
        if self.image != nil{
            imageArray.append(self.image)
        }
        else{
            imageArray.append(UIImage(named:"1031"))
        }
        let stitchedImage:UIImage = CVWrapper.processWithArray(imageArray) as UIImage
        dispatch_async(dispatch_get_main_queue()) {
        print("stichedImage %@", stitchedImage)
        let imageView:UIImageView = UIImageView.init(image: stitchedImage)
        self.imageView = imageView
        self.scrollView.addSubview(self.imageView!)
        self.scrollView.backgroundColor = UIColor.blackColor()
        self.scrollView.contentSize = self.imageView!.bounds.size
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.delegate = self
        self.scrollView.contentOffset = CGPoint(x: -(self.scrollView.bounds.size.width - self.imageView!.bounds.size.width)/2.0, y: -(self.scrollView.bounds.size.height - self.imageView!.bounds.size.height)/2.0)
        print("scrollview \(self.scrollView.contentSize)")
        self.spinner.stopAnimating()
        }
        }
    }
    
    
    func viewForZoomingInScrollView(scrollView:UIScrollView) -> UIView? {
        return self.imageView!
    }
    
}
