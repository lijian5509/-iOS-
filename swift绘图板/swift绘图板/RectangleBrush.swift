//
//  RectangleBrush.swift
//  swift绘图板
//
//  Created by mini on 15/11/26.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class RectangleBrush: BaseBrush {
    
    override func drawInContext(context: CGContextRef) {
        CGContextAddRect(context, CGRect(origin: CGPoint(x: min(beginPoint.x, endPoint.x), y: min(beginPoint.y, endPoint.y)), size:CGSize(width: abs(endPoint.x - beginPoint.x), height: abs(endPoint.y - beginPoint.y))))
    }

}
