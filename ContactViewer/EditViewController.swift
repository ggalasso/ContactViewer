//
//  EditViewController.swift
//  ContactViewer
//
//  Created by Giovanni Galasso on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var editIdLabel: UILabel!
    @IBOutlet weak var cNameField: UITextField!
    @IBOutlet weak var cTitleField: UITextField!
    @IBOutlet weak var cPhoneField: UITextField!
    @IBOutlet weak var cEmailField: UITextField!
    @IBOutlet weak var cTwitterField: UITextField!
    
    var editContact : Contact? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
        if let editContact: Contact = self.editContact {
            if let label = self.editIdLabel {
                label.text = editContact.id
                cNameField.text = editContact.name
                cTitleField.text = editContact.title
                cPhoneField.text = editContact.phone
                cEmailField.text = editContact.email
                cTwitterField.text = editContact.twitterId
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit"
        //Programatically add done button with saveContact function.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "saveContact:")
        self.navigationItem.rightBarButtonItem = doneButton
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveContact(sender:UIBarButtonItem) {
        if let c: Contact = self.editContact {
            var update : Boolean = 0
            if(cNameField.text != c.name) {
                if(cNameField.text == "") {
                    var alert = UIAlertController(title: "Error!", message: "Name cannot be empty.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                } else {
                    c.name = cNameField.text
                    println("Contact name changed.")
                    update = 1
                }
            }
            if(cTitleField.text != c.title) {
                c.title = cTitleField.text
                println("Contact title changed.")
                update = 1
            }
            if(cPhoneField.text != c.phone) {
                c.phone = cPhoneField.text
                println("Contact phone changed.")
                update = 1
            }
            if(cEmailField.text != c.email) {
                c.email = cEmailField.text
                println("Contact email changed.")
                update = 1
            }
            if(cTwitterField.text != c.twitterId) {
                c.twitterId = cTwitterField.text
                println("Contact twitter changed.")
                update = 1
            }
            //If an update was made update the contact and switch back to the detail screen.
            if(update == 1) {
                var cm = ContactManager.sharedInstance
                //Write the contact to file after updating it.
                cm.updateContact(c)
                var fh = FileHandler()
                fh.writeContactsToFile()
                navigationController?.popViewControllerAnimated(true)
            }
        }
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
