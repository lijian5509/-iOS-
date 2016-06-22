//
//  ContactsViewController.swift
//  ContactsFR-读取联系人
//
//  Created by mini on 15/10/19.
//  Copyright © 2015年 mini. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UITableViewController,CNContactPickerDelegate {

    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置右导航栏按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Picker", style:UIBarButtonItemStyle.Plain, target: self, action:"showPicker:")
        
        //获取通讯录数据信息
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            self.contacts = self.findContacts()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
            
    }
    
    //获取通讯录数据信息
    func findContacts() -> [CNContact] {
        let store = CNContactStore() //CNContactStore 是一个用来读取和保存联系人的新的类
        
        //创建一个指定条件的请求，通过这个 query 的请求去获取某些结果。创建一个 CNContactFetchRequest ，我们可以通过设置 contact keys 的数组，来获取我们需要的结果。
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactImageDataKey,
            CNContactPhoneNumbersKey]
        let fetchFRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        var contacts = [CNContact]()
        
        do {
            //从 CNContactStore 中遍历所有符合我们需求的联系人
            try! store.enumerateContactsWithFetchRequest(fetchFRequest, usingBlock: { (let contact, let stop) -> Void in
                contacts.append(contact)
                })
        }
        
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return contacts
    }
    
    
    // ContactsUI 选择联系人
    func showPicker(sender : UIBarButtonItem) {
        
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        self.presentViewController(contactPicker, animated: true, completion: nil)
        
    }
    // ContactsUI 选择后回调
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let phoneNumber = contactProperty.value as! CNPhoneNumber
        print(contact.givenName)
        print(phoneNumber.stringValue)
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.contacts.removeAtIndex(indexPath.row)
            self.tableView .reloadData()
        }else {
            
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let contact = contacts[indexPath.row] as CNContact
        
        cell.textLabel?.text = "\(contact.givenName) \(contact.familyName)"
      
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let viewC = segue.destinationViewController as! ViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                let object = self.contacts[indexpath.row] 
                viewC.contact = object
            }
            viewC.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
