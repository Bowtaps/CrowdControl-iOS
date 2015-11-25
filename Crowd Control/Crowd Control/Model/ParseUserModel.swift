//
//  ParseUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/28/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//
import Parse
import Foundation

/// This class extends the UserModel protocol and is the class to access the current user's information
/// from Parse.
class ParseUserModel: UserModel {
    /// String containing the current user's username (optional)
    var username: String?
    /// Boolean to store if the user has verified their email with parse (optional)
    /// True - Email has been verified
    /// False - Email has NOT been verified
    var emailVerified: Bool?
    /// String containing the current users email (optional)
    var email: String?
    /// String containing the current users phone nuber (optional)
    var phone: String?
    /// String containing the objectId for the row in the Parse Class (optional)
    var id: String?
    /// Date that the object was created
    var created: NSDate?
    /// Date that the object was updated
    var update: NSDate?
    /// Flag to determine if anything has been modified since the Object was fetched or stored from Parse.
    /// True - Modified and not stored on Parse
    /// False - Up to date with remote Parse Server
    var modified: Bool
    //// Constructer to set all optionals to nil
    init(){
        self.username = nil
        self.emailVerified = nil
        self.email = nil
        self.phone = nil
        
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