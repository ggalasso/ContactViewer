//
//  AddContactViewController.swift
//  ContactViewer
//
//  Created by Giovanni Galasso on 4/13/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var cName: UITextField!
    @IBOutlet weak var cTwitter: UITextField!
    @IBOutlet weak var cEmail: UITextField!
    @IBOutlet weak var cPhoneNumber: UITextField!
    @IBOutlet weak var cTitle: UITextField!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var cNameLabel: UILabel!
    
    @IBAction func saveContact(sender: AnyObject) {
        if(!cName.text.isEmpty ) {
            //If contact name isn't empty then create contact object and write it to the file. 
            let newContact = Contact(name: cName.text, phone: cPhoneNumber.text, title: cTitle.text, email: cEmail.text, twitterId:cTwitter.text)
            ContactManager.sharedInstance.addContact(newContact)
            IDLabel.text = newContact.id
            NSLog("Cname: \(cName.text)")
            var fh = FileHandler()
            fh.writeContactsToFile()
            navigationController?.popViewControllerAnimated(true)
        } else if (cName.text == "") {
            //If contact name is empty present an alert that contact cannot be saved.
            var alert = UIAlertController(title: "Error!", message: "Name is required.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            cNameLabel.textColor = UIColor.redColor()
        }
    }
    
}
