//
//  ParseUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/28/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

class ParseUserModel: CCUserModel {
    //CCUser Table in Parse
    var status: String?
    var location: (Double, Double)
    var preferences: String?
    
    //ParseUser Table in Parse
    var objectId: String
    var username: String
    var password: String
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
        self.password = ""
        self.authData = ""
        self.emailVerified = true
        self.email = ""
        self.createdAt = NSDate.init()
        self.updatedAt = NSDate.init()
    }
    
    func load(){
        //Load data from Parse
        print("Load from Parse")
    }
    func loadAsync(){
        print("Load Async from Parse")
    }
    func save(){
        print("Send data to Parse")
    }
    func saveAsync(){
        print("Send Async data to Parse")
    }
}