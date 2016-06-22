//
//  BaseBrush.swift
//  swift绘图板
//
//  Created by mini on 15/11/25.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

import CoreGraphics

protocol PaintBrush {
    //表示是否是连续不断的绘图
    func supportedContinuousDrawing() -> Bool
    //基于Context的绘图方法，子类必须实现具体的绘图
    func drawInContext(context: CGContextRef)
}

class BaseBrush: NSObject ,PaintBrush{
    var beginPoint: CGPoint!//开始点
    var endPoint: CGPoint!//结束点
    var lastPoint: CGPoint?//最后一个点的位置
    var strokeWith: CGFloat!//画笔宽
    func supportedContinuousDrawing() -> Bool {
        return false
    }
    
    func drawInContext(context: CGContextRef) {
        assert(false, "must implements in subclass.")
    }
    
}
