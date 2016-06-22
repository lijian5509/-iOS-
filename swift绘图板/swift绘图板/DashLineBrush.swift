//
//  DashLineBrush.swift
//  swift绘图板
//
//  Created by mini on 15/11/25.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class DashLineBrush: BaseBrush {

    override func drawInContext(context: CGContextRef) {
        let lengths: [CGFloat] = [self.strokeWith * 3, self.strokeWith * 3]
        CGContextSetLineDash(context, 0, lengths, 2)
        CGContextMoveToPoint(context, beginPoint.x, beginPoint.y)
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
    }
    
}
