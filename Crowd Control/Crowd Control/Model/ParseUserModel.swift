//
//  ParseUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/28/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//
import Parse
import Foundation

class ParseUserModel: CCUserModel {
    //CCUser Table in Parse
    var status: String?
    var location = (0.0,0.0)
    var displayName = ""
    
    //ParseUser Table in Parse
    var objectId = "" //do we really need this?
    var username = ""
    var preferences: String?
    var authData: String //do we really need this?
    var emailVerified = false
    var email = ""
    var createdAt: NSDate
    var updatedAt: NSDate
    
    init(){
        self.status = nil
        self.preferences = nil
        self.authData = ""
        self.createdAt = NSDate.init()
        self.updatedAt = NSDate.init()
    }
    
    func load(){
        //Load data from Parse
        print("Load from Parse")
        let user = PFUser.currentUser()
        let query = PFQuery(className: "CCUser")
        query.whereKey("UserId", equalTo: user!)
        //TODO: Catch errors
        let resp = try! query.findObjects()
        print(user?.objectId)
        print(resp)
    }
    func loadAsync(){
        print("Load Async from Parse")
        let user = PFUser.currentUser()
        let query = PFQuery(className: "CCUser")
        query.whereKey("UserId", equalTo: user!)
        query.findObjectsInBackgroundWithBlock {
            (object: [PFObject]?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                print(object)
            }
        }
    }
    func save(){
        print("Send data to Parse")
		
        let user = PFUser.currentUser()
        let ccuser = PFObject(className: "CCUser")
        ccuser["DisplayName"] = self.displayName
        ccuser["UserID"] = user!
        let resp = try! ccuser.save()
        print(resp)
    }
    func saveAsync(){
        print("Send Async data to Parse")
        let user = PFUser.currentUser()
        let ccuser = PFObject(className: "CCUser")
        ccuser["DisplayName"] = self.displayName
        ccuser["UserID"] = user!
        ccuser.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("success")
            } else {
                // There was a problem, check error.description
                print(error?.description)
            }
        }
    }
}