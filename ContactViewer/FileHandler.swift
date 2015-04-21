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
    var textRead = ""
    
    func readFromFile() -> String {
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            textRead = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!

        } else {
            return "Unable to read from file."
        }
        if(textRead != "") {
            let myData:NSData? = textRead.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            var jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(myData!, options: NSJSONReadingOptions.MutableContainers, error: nil);
            
            if let lJsonArray = jsonResult as? Array<AnyObject> {
                var cm = ContactManager.sharedInstance
                for(var i = 0; i < lJsonArray.count; i++) {
                    var cId = lJsonArray[i].objectForKey("id")! as AnyObject? as String
                    var cName = lJsonArray[i].objectForKey("name")! as AnyObject? as String
                    var cEmail = lJsonArray[i].objectForKey("email") as AnyObject? as String
                    var cTitle  = lJsonArray[i].objectForKey("title") as AnyObject? as String
                    var cPhone = lJsonArray[i].objectForKey("phone") as AnyObject? as String
                    var cTwitterId = lJsonArray[i].objectForKey("twitterId") as AnyObject? as String
                    //TODO Check if contact ID already exists in the ContactManager
                    var newContact = Contact(name: cName, phone: cPhone, title: cTitle, email: cEmail, twitterId: cTwitterId, id: cId)
                    cm.addContact(newContact)
                }
                println("Count: \(lJsonArray.count)")
            }
            return textRead
        } else {
            return "Error reading from file"
        }
    }
    
    //func writeContactsToFile (dataWrite:NSData) {
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
        //let str = NSString(data: tmpJSON, encoding:NSUTF8StringEncoding)!
        //println(str)
        return tmpJSON
    }
    
    func convertFromJSON(jsonString:NSString) {
    /*    //let responseList = NSJSONSerialization.dataWithJSONObject(Contact, options: , error: NSErrorPointer) as NSDictionary
        
        // convert String to NSData
        var data: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
        var error: NSError?
        
        // convert NSData to 'AnyObject'
        let anyObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0),
            error: &error)
        println("Error: \(error)")
        
        // convert 'AnyObject' to Array<Business>
        //list = self.parseJson(anyObj!)
    */
        
    }
    
    
    
    func convertJSONToString(data: NSData) -> String {
        return NSString(data: data, encoding: NSUTF8StringEncoding)!
    }
}
