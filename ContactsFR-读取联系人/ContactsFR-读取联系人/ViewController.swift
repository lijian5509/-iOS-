//
//  ViewController.swift
//  ContactsFR-读取联系人
//
//  Created by mini on 15/10/19.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController {

    var contact : CNContact!
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var board: Board!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if contact.imageData != nil {
            self.headImageView.image = UIImage(data: contact.imageData!)
        } else {
            headImageView.image = UIImage(named:"嗨家icon80")
        }
        
        nameLabel.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
        
        if let phoneNLabel  = self.phoneNumLabel {
            var numberArray = [String]()
            for number in contact.phoneNumbers {
                let phoneNumber = number.value as! CNPhoneNumber
                numberArray.append(phoneNumber.stringValue)
            }
            
            
            
            phoneNLabel.text = numberArray.joinWithSeparator(", ")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

