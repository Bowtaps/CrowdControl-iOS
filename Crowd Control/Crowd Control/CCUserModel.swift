//
//  CCUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/22/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

class CCUserModel {
    var status: String
    var location: (Double, Double)
    var preferences: String
    var thing: String
    
    init(status: String, location: (Double, Double), preferences: String, thing: String){
        self.status = status
        self.location = location
        self.preferences = preferences
        self.thing = thing
        
    }
}

extension CCUserModel {
    func getCCUser() -> CCUserModel{
        return self
    }
    func getUsername() -> String {
        //Do get username here
        return "TODO"
    }
    func getLocation() -> (Double, Double) {
        return self.location
    }
    func getPreferences() -> String {
        return self.preferences
    }
    func getStatus() -> String {
        return self.status
    }
    func setLocation(long: Double, lat: Double){
        self.location = (long, lat)
    }
    func setPreferences(pref: String){
        self.preferences = pref
    }
    func setStatus(status: String){
        self.status = status
    }
}