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
    var location: (Double, Double)
    var preferences: String?
    
    //ParseUser Table in Parse
    var objectId: String
    var username: String
    var authData: String
    var emailVerified: Bool
    var email: String
    var createdAt: NSDate
    var updatedAt: NSDate
    
    init(){
        self.status = ""
        self.location = (0.0,0.0)
        self.preferences = ""
        self.objectId = ""
        self.username = ""
        self.authData = ""
        self.emailVerified = true
        self.email = ""
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
            }
        }
    }
    func save(){
        print("Send data to Parse")
		/*
        let user = PFUser.currentUser()
        let ccuser = PFObject(className: "CCUser")
        ccuser["location"] = self.location
        ccuser["preferences"] = self.preferences
        ccuser["status"] = self.status
        ccuser.whereKey("UserId", user!)
        let resp = ccuser.save()
*/
    }
    func saveAsync(){
        print("Send Async data to Parse")
		/*
        let user = PFUser.currentUser()
        let ccuser = PFObject(className: "CCUser")
        ccuser["location"] = self.location
        ccuser["preferences"] = self.preferences
        ccuser["status"] = self.status
        ccuser.whereKey("UserId", user!)
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
*/
    }
}