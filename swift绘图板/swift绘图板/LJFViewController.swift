//
//  ViewController.swift
//  swift绘图板
//
//  Created by mini on 15/11/25.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class LJFViewController: UIViewController {

    var brushes = [PencilBrush(),LineBrush(), DashLineBrush(), RectangleBrush(), EllipseBrush(), EraserBrush()]
    
    @IBOutlet weak var board: Board!
    
    var toolbarEditingItems: [UIBarButtonItem]?
    var currentSettingsView: UIView?
    @IBOutlet var toolbarConstraintHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.board.brush = brushes[0]
    }

    @IBAction func switchBrush(sender: UISegmentedControl) {
        
        assert(sender.tag < self.brushes.count, "!!!!")
        
        self.board.brush = self.brushes[sender.selectedSegmentIndex]
        
    }
    
    @IBAction func paintingBrushSetting(sender: UIBarButtonItem) {
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

