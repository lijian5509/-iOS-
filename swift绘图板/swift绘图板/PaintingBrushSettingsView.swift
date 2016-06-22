//
//  PaintingBrushSettingsView.swift
//  swift绘图板
//
//  Created by mini on 15/11/26.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class PaintingBrushSettingsView: UIView {

    var strokeWidthChangedBlock: ((strokeWidth: CGFloat) -> Void)?
    var strokeColorChangedBlock: ((strokeColor: UIColor) -> Void)?
    @IBOutlet weak var colorPicker: RGBColorPicker!
    @IBOutlet weak var strokeColorPreView: UIView!
    @IBOutlet weak var strokeWidthSlider: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.strokeColorPreView.layer.borderColor = UIColor.blackColor().CGColor
        self.strokeColorPreView.layer.borderWidth = 1
        self.colorPicker.colorChangedBlcok = {
            [unowned self] (color: UIColor) in
            self.strokeColorPreView.backgroundColor = color
            if let strokeColorChangedBlock = self.strokeColorChangedBlock {
                strokeColorChangedBlock(strokeColor: color)
            }
        }
        self.strokeWidthSlider.addTarget(self, action: "strokeWidthChanged:", forControlEvents: .ValueChanged)
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            self.strokeColorPreView.backgroundColor = self.backgroundColor
            self.colorPicker.setCurrentColor(self.backgroundColor!)
            super.backgroundColor = oldValue
        }
    }
    
    func strokeWidthChanged(slider: UISlider) {
        if let strokeWidthChangedBlock = self.strokeWidthChangedBlock {
            strokeWidthChangedBlock(strokeWidth: CGFloat(slider.value))
        }
    }

}
