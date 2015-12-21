//
//  line.swift
//  akapp
//
//  Created by Akshay on 12/14/15.
//  Copyright © 2015 cornell university. All rights reserved.
//

import UIKit


class Line{
    var start:CGPoint
    var end:CGPoint
    var color:Bool
    
    init(_start:CGPoint,_end:CGPoint,_color:Bool)
    {
        start = _start
        end = _end
        color = _color
    }
    
}