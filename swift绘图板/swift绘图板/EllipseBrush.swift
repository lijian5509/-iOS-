//
//  EllipseBrush.swift
//  swift绘图板
//
//  Created by mini on 15/11/26.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class EllipseBrush: BaseBrush {
    
    override func drawInContext(context: CGContextRef) {
        CGContextAddEllipseInRect(context, CGRect(origin: CGPoint(x: min(beginPoint.x,endPoint.x), y: min(beginPoint.y, endPoint.y)), size: CGSize(width: abs(endPoint.x - beginPoint.x), height: abs(endPoint.y - beginPoint.y))))
    }
}
