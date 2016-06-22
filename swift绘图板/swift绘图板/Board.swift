//
//  Board.swift
//  swift绘图板
//
//  Created by mini on 15/11/25.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

enum DrawingState {
    case Began, Moved, Ended
}

class Board: UIImageView {
    
    var strokeWidth: CGFloat
    var strokeColor: UIColor
    
    var brush: BaseBrush?
    private var realImage: UIImage?
    
    private var drawingState: DrawingState!
    
    init() {
        self.strokeColor = UIColor.blackColor()
        self.strokeWidth = 1
        super.init(frame: CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.strokeColor = UIColor.blackColor()
        self.strokeWidth = 1
        super.init(coder: aDecoder)!
    }

    // - touched methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let brush = self.brush {
            brush.lastPoint = nil
            brush.beginPoint = touches.first?.locationInView(self)
            brush.endPoint = brush.beginPoint
            self.drawingState = .Began
            self.drawingImage()
        }
        
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let brush = self.brush {
            brush.endPoint = touches.first?.locationInView(self)
            self.drawingState = .Moved
            self.drawingImage()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let bursh = self.brush {
            bursh.endPoint = touches.first?.locationInView(self)
            self.drawingState = .Ended
            self .drawingImage()
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let brush = self.brush {
            brush.endPoint = nil
        }
    }
    
    //需要防止brush 为nil 的情况，以及为brush 设置好begine
    private func drawingImage() {
        if let brush = self.brush {
            //1.
            UIGraphicsBeginImageContext(self.bounds.size)
            //2.
            let context = UIGraphicsGetCurrentContext()
            UIColor.clearColor().setFill()
            UIRectFill(self.bounds)
//            CGContextSetLineCap(context, kCGLineCapRound)
            CGContextSetLineCap(context, CGLineCap.Round)
            CGContextSetLineWidth(context, self.strokeWidth)
            CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor)
            //3.
            if let realImage = self.realImage {
                realImage.drawInRect(self.bounds)
            }
            //4.
            brush.strokeWith = self.strokeWidth
            brush.drawInContext(context!)
            CGContextStrokePath(context)
            //5.
            let previewImage = UIGraphicsGetImageFromCurrentImageContext()
            if self.drawingState == .Ended || brush.supportedContinuousDrawing() {
                self.realImage = previewImage
            }
            UIGraphicsEndImageContext()
            //6/
            self.image = previewImage
            brush.lastPoint = brush.endPoint
        }
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
