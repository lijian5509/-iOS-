//
//  ViewController.swift
//  swift仿微信键盘变化
//
//  Created by mini on 15/10/20.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var keyBoardView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        @IBOutlet weak var board: Board!
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillhide:", name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.keyBoardView.resignFirstResponder()
    }
    
    func keyBoardWillShow(note:NSNotification)
    {
        //1.将通知的用户信息取出,转化为字典类型
        let userInfo = note.userInfo as! NSDictionary
        //2.通过对应的键UIKeyboardFrameEndUserInfoKey，取出键盘位置信息
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //3.通过UIKeyboardAnimationDurationUserInfoKey,取出动画时长信息
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //4.由于取出的位置信息是绝对的，所以要将其转换为对应于当前view的位置，否则位置信息会出错！
//        var keyBoardBoudsRect = self.view.convertRect(keyBoardBounds, toView: nil)
//        
//        var keyBoardViewFrame = keyBoardView.frame
        let deltaY = keyBoardBounds.size.height
        
        let animations :(() -> Void) = {
            
            //使输入框的高度减少deltaY也就是跟随键盘的位置向上移动;
            self.keyBoardView.transform = CGAffineTransformMakeTranslation(0, -deltaY)
        }
        
        if duration > 0 {
            
            //这里是将时间曲线信息(一个64为的无符号整型)转换为UIViewAnimationOptions类型，要通过左移16来完成类型转换。
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as!NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
        }else {
            animations()
        }
        
    }
    
    func keyBoardWillhide(note:NSNotification)
    {
        let userInfo = note.userInfo as! NSDictionary
        let durarion = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations :(() -> Void) = {
            self.keyBoardView.transform = CGAffineTransformIdentity
        }
        if durarion > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(durarion, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

