//
//  LineBrush.swift
//  swift绘图板
//
//  Created by mini on 15/11/25.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class LineBrush: BaseBrush {
    override func drawInContext(context: CGContextRef) {
        CGContextMoveToPoint(context, beginPoint.x, beginPoint.y)
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
    }
}
