//
//  EditorView.swift
//  akapp
//
//  Created by Akshay on 12/14/15.
//  Copyright © 2015 cornell university. All rights reserved.
//

import UIKit
import AVFoundation

class EditorView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var lines:[Line] = []
    var last:CGPoint!
    var Green:Bool = true
    var image:UIImage!
    



    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.last = touches.first!.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newpoint = touches.first!.locationInView(self)
        self.lines.append(Line(_start: last,_end: newpoint,_color: Green))
        self.last = newpoint
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let targetBounds:CGRect = self.layer.bounds;

        let context = UIGraphicsGetCurrentContext()
        // draw the image
        if self.image != nil {
            let imageRect:CGRect = AVMakeRectWithAspectRatioInsideRect(image.size,targetBounds);
            CGContextDrawImage(context, imageRect, image.CGImage);
        }
//        let imagePoint = CGPointMake(0, 0);image?.drawAtPoint(imagePoint)
        CGContextSetLineWidth(context,5)
        CGContextSetLineCap(context, CGLineCap.Round)
        for line in lines{
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
            if line.color{
                CGContextSetRGBStrokeColor(context, 0, 1, 0, 1)
            }
            else{
                CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
            }
            CGContextStrokePath(context)
        }
    }
}



