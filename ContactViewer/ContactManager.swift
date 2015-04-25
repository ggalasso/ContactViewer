//
//  ContactManager.swift
//  ContactViewer
//
//  Created by Giovanni Galasso on 4/15/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import Foundation
//private let _ContactManagerSharedInstance : ContactManager

class ContactManager: NSObject {
    
    var contactList = [Contact]()

    class var sharedInstance: ContactManager {
        struct Singleton {
            static let instance = ContactManager()
        }
        return Singleton.instance
    }
    
    override init() {
        //Considered adding default contacts here.
    }

    func getContactList() -> [Contact] {
        return contactList
    }
    
    //Add a contact to list.
    func addContact(newContact: Contact) {
        contactList.append(newContact)
        NSLog("New contact inserted.\n")
    }
    
    //Delete passed contact from list.
    func deleteContact(c: Contact) {
        if let index = find(contactList, c) {
            contactList.removeAtIndex(index)
            NSLog("Contact at index: \(index) was removed.\n")
        }  else {
            NSLog("Contact not found.\n")
        }
    }
    
    //Get the number of contact stored. 
    func getContactListSize() -> Int {
        return contactList.count
    }
    
    func updateContact(c: Contact) {
        for contact in contactList {
            if c.id == contact.id {
                contact.name = c.name
                contact.title = c.title
                contact.phone = c.phone
                contact.email = c.email
                contact.twitterId = c.twitterId
                println("Updated contact: \(contact.name)")
                return;
            }
        }
    }

}