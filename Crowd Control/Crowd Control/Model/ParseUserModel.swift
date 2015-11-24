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
    var objectId = "" //do we really need this?
    
    //ParseUser Table in Parse
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
        //Find the object in Parse
        let query = PFQuery(className: "CCUser")
        //Look for objectId that matches the one stored
        query.whereKey("objectId", equalTo: self.objectId)
        //TODO: Catch errors
        let resp = try! query.findObjects() as [PFObject]
        print(resp)
    }
    func loadAsync(){
        print("Load Async from Parse")
        //create query to find object
        let query = PFQuery(className: "CCUser")
        //look for matching objectId
        query.whereKey("objectId", equalTo: self.objectId)
        //run the query
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error != nil || objects == nil {
                print("The request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                //should only return one
                for object in objects! {
                    //print(object)
                    self.objectId = object.objectId!
                    self.displayName = object["DisplayName"] as! String
                    print("Display Name: " + self.displayName)
                    self.save()
                }
            }
        }
    }
    func save(){
        //first have to find the object in parse
        let query = PFQuery(className:"CCUser")
        print(self.objectId)
        print(self.displayName)
        //get the object with matching objectId
        let userProfile = try! query.getObjectWithId(self.objectId)
        //changing the display name to test if it works remove and this is where
        //we set all of the values for parse
        userProfile["DisplayName"] = "testingAgain"
        //save to the object on parse
        let resp = try! userProfile.save()
        print(resp)
    }
    func saveAsync(){
        print("Send Async data to Parse")
        //for testing I am changing the displayName
        self.displayName = "testing 1,2,3"
        //find the object in parse
        let ccuser = PFQuery(className: "CCUser")
        //get the object from parse with matching objectId
        ccuser.getObjectInBackgroundWithId(self.objectId) {
            (userProfile: PFObject?, error: NSError?) -> Void in
            if error != nil {
                //display the error if it exists
                print(error)
            } else if let userProfile = userProfile {
                //set the display name for testing
                //this is where we would set the value
                userProfile["DisplayName"] = self.displayName
                //save the object to parse
                userProfile.saveInBackground()
            }
        }

    }
    func create(){
        //Not sure if we should have this here but it does seem to make sense to 
        //have a create function just for the first time a user signs in to actually
        //create the object in parse
        //grab the current user information that was created through signing up
        let user = PFUser.currentUser()
        //set the fields that pertain to the Parse User object
        self.email = user!.email!
        self.username = user!.username!
        //create the CCUser object locally to save to parse
        let ccuser = PFObject(className: "CCUser")
        //set the CCUser fields
        ccuser["UserID"] = user!
        ccuser["DisplayName"] = self.displayName
        //create the object Asynchronously
        ccuser.saveInBackground()
    }
}