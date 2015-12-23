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
    var points:[Epoint] = []
    var last:CGPoint!
    var Green:Bool = true
    var image:UIImage!
    var brushSize:CGFloat = 45.0
    

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.last = touches.first!.locationInView(self)
        self.points.append(Epoint(_point:touches.first!.locationInView(self),_color:Green,_size:brushSize))
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newpoint = touches.first!.locationInView(self)
        self.lines.append(Line(_start: last,_end: newpoint,_color: Green,_size:brushSize))
        self.last = newpoint
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
//        if self.image != nil   {
//        let targetBounds:CGRect = self.layer.bounds;
//            let imageRect:CGRect = AVMakeRectWithAspectRatioInsideRect(image.size,targetBounds);
//            self.image.drawInRect(imageRect)
//        }
        CGContextSetLineCap(context, CGLineCap.Round)
        for p in points{
            let r = CGRectMake(p.point.x - (p.size/2), p.point.y - (p.size/2), p.size, p.size);
            if p.color{
                CGContextSetFillColor(context, [0.2,1,0.2,0.5]);
            }
            else{
                CGContextSetFillColor(context, [1,0.2,0.3,0.5]);
            }
            CGContextFillEllipseInRect(context,r)
        }
        for line in lines{
                CGContextBeginPath(context)
                CGContextSetLineWidth(context,line.size)
                CGContextMoveToPoint(context, line.start.x, line.start.y)
                CGContextAddLineToPoint(context, line.end.x, line.end.y)
                if line.color{
                    CGContextSetRGBStrokeColor(context, 0.2, 1, 0.2, 0.5)
                }
                else{
                    CGContextSetRGBStrokeColor(context, 1, 0.2, 0.3, 0.5)
                }
                CGContextStrokePath(context)
            }
    }
}



