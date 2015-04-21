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
        //return _ContactManagerSharedInstance
    }
    
    override init() {
        
//        let contact1 = Contact(name: "Walter White", phone: "612-664-1234", title: "Chemist", email: "walt@bb.com", twitterId: "ww")
//        let contact2 = Contact(name: "Skyler White", phone: "612-664-1235", title: "Mom", email: "sky@bb.com", twitterId: "skyblue")
//        let contact3 = Contact(name: "Jessie Pinkman", phone: "612-664-1236", title: "Junkie", email: "jessie@bb.com", twitterId: "jp")
//        contactList.append(contact1)
//        contactList.append(contact2)
//        contactList.append(contact3)
        //FileHandler.readFromFile()

        
    }
    
//    func convertContactListToDict(contacts:[Contact]) -> NSDictionary {
//        for (c) in contacts {
//        }
//        NSError err = nil
//        NSArray contacts = [NSJSONSerialization .JSONObjectWithData(contacts, options: .allZeros, error: err)]
//        
//        //NSError *e = nil;
//        //NSArray *contacts = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
//        if (!contacts) {
//            NSLog("Error parsing JSON:")
//        }
//        
//        if (!jsonArray) {
//            NSLog(@"Error parsing JSON: %@", e);
//        } else {
//            for(NSDictionary *item in jsonArray) {
//                NSLog(@"Item: %@", item);
//            }
//        }
//    }

    func getContactList() -> [Contact] {
        return contactList
    }
    
    func addContact(newContact: Contact) {
        contactList.append(newContact)
        NSLog("New contact inserted.\n")
    }
    
    func deleteContact(c: Contact) {
        if let index = find(contactList, c) {
            contactList.removeAtIndex(index)
            NSLog("Contact at index: \(index) was removed.\n")
        }  else {
            NSLog("Contact not found.\n")
        }
    }
    
    func getContactListSize() -> Int {
        return contactList.count
    }

}