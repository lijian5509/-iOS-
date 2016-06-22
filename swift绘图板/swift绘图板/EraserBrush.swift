//
//  EraserBrush.swift
//  swift绘图板
//
//  Created by mini on 15/11/26.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class EraserBrush: PencilBrush {
    override func drawInContext(context: CGContextRef) {
        CGContextSetBlendMode(context, CGBlendMode.Clear)
        super.drawInContext(context)
    }
}
