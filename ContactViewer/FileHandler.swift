//
//  fileHandler.swift
//  ContactViewer
//
//  Created by Giovanni Galasso on 4/14/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import Foundation
class FileHandler: NSObject {
    
    let file = "contacts.json"

    
    func readFromFile() -> String {
        var textRead = ""
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            if let fileContents = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
                textRead = fileContents
            }

        } else {
            return "Unable to read: file directory may not be accessible."
        }
        if(textRead != "") {
            let myData:NSData? = textRead.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            convertFromJSON(myData!)
            return textRead
        } else {
            return "Error reading: contents of file may be empty."
        }
    }
    
    //Convert the contact list to JSON and write it to the file.
    func writeContactsToFile () {
        var dataWrite = convertToJSON(ContactManager.sharedInstance.getContactList())
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            dataWrite.writeToFile(path, atomically: false)
        } else {
            println("Unable to write to file.")
        }
        
    }
    
    //Convert array of contacts to JSON format.
    func convertToJSON(myContacts:[Contact]) -> NSData {
        var data = [NSDictionary]()
        var myDict = NSDictionary()
        
        for var i = 0; i < myContacts.count; ++i {
            myDict = [
                "id":myContacts[i].id,
                "name":myContacts[i].name,
                "title":myContacts[i].title,
                "phone":myContacts[i].phone,
                "email":myContacts[i].email,
                "twitterId":myContacts[i].twitterId
                ] as NSDictionary
            data.append(myDict)
        }
        var error = NSError?()
        var tmpJSON = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: &error)!
        //Used for debugging
        //let str = NSString(data: tmpJSON, encoding:NSUTF8StringEncoding)!
        //println(str)
        return tmpJSON
    }
    
    
    //Function to convert JSON list to Contact objects and add them with the Contact Manager.
    func convertFromJSON(myData:NSData) {
        
        var jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(myData, options: NSJSONReadingOptions.MutableContainers, error: nil);
        
        if let lJsonArray = jsonResult as? Array<AnyObject> {
            var cm = ContactManager.sharedInstance
            //Loop through each contact read in and add them to the Contact Manager.
            for(var i = 0; i < lJsonArray.count; i++) {
                var cId = lJsonArray[i].objectForKey("id")! as AnyObject? as String
                var cName = lJsonArray[i].objectForKey("name")! as AnyObject? as String
                var cEmail = lJsonArray[i].objectForKey("email") as AnyObject? as String
                var cTitle  = lJsonArray[i].objectForKey("title") as AnyObject? as String
                var cPhone = lJsonArray[i].objectForKey("phone") as AnyObject? as String
                var cTwitterId = lJsonArray[i].objectForKey("twitterId") as AnyObject? as String
                //TODO Check if contact ID already exists in the ContactManager
                //Since we re only reading in on the initial load we don't need to verify if the contact already exists by ID.
                var newContact = Contact(name: cName, phone: cPhone, title: cTitle, email: cEmail, twitterId: cTwitterId, id: cId)
                cm.addContact(newContact)
            }
            //Debugging number of contacts read in through the file.
            println("Contact count: \(lJsonArray.count)")
        }
        
    }
    
    
    
    func convertJSONToString(data: NSData) -> String {
        return NSString(data: data, encoding: NSUTF8StringEncoding)!
    }
}
