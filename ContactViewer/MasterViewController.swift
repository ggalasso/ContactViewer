//
//  MasterViewController.swift
//  ContactViewer
//
//  Created by Giovanni Galasso on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    //var objects = [AnyObject]()
    //var contacts = [Contact]()
    var fh = FileHandler()
    var cm = ContactManager.sharedInstance
    //var contacts = ContactManager.sharedInstance.getContactArray()!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Read from file and print out what was read.
        println(fh.readFromFile())
        //If the file was empty then load some default contacts for the app.
        if cm.contactList.count == 0 {
            loadDefaultContacts()
            println("Default contacts loaded in.")
            fh.writeContactsToFile()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        self.tableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            println("Show detail segue triggered")
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                var contacts = ContactManager.sharedInstance.getContactList()
                let object = contacts[indexPath.row] as Contact
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "showAdd" {
            println("Show add segue triggered")
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as UINavigationController).topViewController as AddContactViewController
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return contacts.count
        return cm.getContactListSize()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let object = cm.getContactList()[indexPath.row] as Contact
        cell.textLabel!.text = object.name
        //hack to avoid making custom cell
        cell.detailTextLabel!.text = "\(object.phone)       \(object.title)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //var contacts = ContactManager.sharedInstance.getContactArray()
            //contacts.removeAtIndex(indexPath.row)
            let object = cm.getContactList()[indexPath.row] as Contact
            cm.deleteContact(object)
            fh.writeContactsToFile()
            //cm.deleteContactById(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            println("Reached inside insert!!!")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let evc = EditViewController(nibName: "EditViewController", bundle: nil)
        //self.navigationController?.pushViewController(evc, animated: true)
    }

    func loadDefaultContacts() {
        let contact1 = Contact(name: "Walter White", phone: "612-664-1234", title: "Chemist", email: "walt@bb.com", twitterId: "ww")
        let contact2 = Contact(name: "Skyler White", phone: "612-664-1235", title: "Mom", email: "sky@bb.com", twitterId: "skyblue")
        let contact3 = Contact(name: "Jessie Pinkman", phone: "612-664-1236", title: "Junkie", email: "jessie@bb.com", twitterId: "jp")
        let contact4 = Contact(name: "Saul Goodman", phone: "612-664-1237", title: "Lawyer", email: "bettercallsaul@bb.com", twitterId: "callsaul@")
        
        cm.addContact(contact1)
        cm.addContact(contact2)
        cm.addContact(contact3)
        cm.addContact(contact4)
    }

}

