//
//  CCUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/22/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

class CCUserModel {
    //CCUser Table in Parse
    var status: String
    var location: (Double, Double)
    var preferences: String
    
    //ParseUser Table in Parse
    var objectId: String
    var username: String
    var password: String
    var authData: String
    var emailVerified: Bool
    var email: String
    var createdAt: NSDate
    var updatedAt: NSDate
    
    init(status: String, location: (Double, Double), preferences: String, objectId: String, username: String, password: String, authData: String, emailVerified: Bool, email: String, createdAt: NSDate, updatedAt: NSDate){
        self.status = status
        self.location = location
        self.preferences = preferences
        self.objectId = objectId
        self.username = username
        self.password = password
        self.authData = authData
        self.emailVerified = emailVerified
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension CCUserModel {
    func getAuthData() -> String{
        return self.authData
    }
    func getCCUser() -> CCUserModel{
        return self
    }
    func getCreatedAt() -> NSDate{
        return self.createdAt
    }
    func getEmail() -> String{
        return self.email
    }
    func getEmailVerified() -> Bool{
        return self.emailVerified
    }
    func getLocation() -> (Double, Double) {
        return self.location
    }
    func getObjectId() -> String{
        return self.objectId
    }
    func getPassword() -> String{
        return self.password
    }
    func getPreferences() -> String {
        return self.preferences
    }
    func getStatus() -> String {
        return self.status
    }
    func getUpdatedAt() -> NSDate{
        return self.updatedAt
    }
    func getUsername() -> String {
        return self.username
    }
    func setLocation(long: Double, lat: Double){
        //save location to parse
        self.location = (long, lat)
    }
    func setPreferences(pref: String){
        //save preferences to parse
        self.preferences = pref
    }
    func setStatus(status: String){
        self.status = status
    }
    func onUpdate(){
        //send all the updated information to parse
    }
}