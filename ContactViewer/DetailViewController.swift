//
//  DetailViewController.swift
//  ContactViewer
//
//  Created by Giovanni Galasso on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!

    
    
    
    var contactID:String = ""
    var myContact:Contact?
    
    var detailItem: Contact? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Contact = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.id
                nameLabel.text = detail.name
                if (detail.title == "") {
                    titleLabel.text = ""
                } else {
                    titleLabel.text = detail.title
                }
                if (detail.phone == "") {
                    phoneLabel.text = ""
                } else {
                    phoneLabel.text = detail.phone
                }
                if (detail.email == "") {
                    emailLabel.text = ""
                } else {
                    emailLabel.text = detail.email
                }
                if (detail.twitterId == "") {
                    twitterLabel.text = ""
                } else {
                    twitterLabel.text = detail.twitterId
                }
            }
            contactID = detail.id
            println("Contact ID is: \(contactID)")
            myContact = detail
        }

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.configureView()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editView" {
            println("Edit view controller segue triggered!")
            println("Contact ID is: \(contactID)")
            let controller = segue.destinationViewController as EditViewController
            //let controller = (segue.destinationViewController as UINavigationController).topViewController as EditViewController
            
            controller.editContact = myContact
            //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            //controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
}

