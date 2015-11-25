//
//  ParseProfileModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 11/25/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// This is the Class that extends the UserProfileModel to implement the connection to Parse.
class ParseProfileModel: UserProfileModel{
    /// String containing the DisplayName of a user
    var displayName: String?
    
    /// String containing the objectId field from Parse
    var id: String?
    /// Date that the object was created on Parse
    var created: NSDate?
    /// Date that the object was updated on Parse
    var update: NSDate?
    /// Flag to determine whether the object has been updated since the last fetch or store from Parse.
    /// True - Object has been modified
    /// False - Object has NOT been Modified
    var modified: Bool
    /// Class Constructor setting all optionals to nil
    init(){
        self.displayName = nil
        self.id = nil
        self.created = nil
        self.update = nil
        self.modified = false
    }
    
    func load(){}
    
    func loadInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?){}
    
    func save(){}
    
    func saveInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?){}
}