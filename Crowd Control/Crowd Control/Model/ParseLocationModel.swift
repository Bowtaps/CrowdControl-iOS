//
//  ParseLocationModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 12/30/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// Parse implementation of the `LocationModel` protocol. Extends the `ParseBaseModel` class.
class ParseLocationModel: ParseBaseModel, LocationModel {
	
    /// Parse table name.
    private static let tableName = "Group"
    
    /// Key corresponding to 'generalLocation' field.
    private static let longitudeKey = "Longitude"
    
    /// Key corresponding to `groupDescription` field.
    private static let latitudeKey = "Latitude"
    
    /// Key corresponding to `groupName` field.
    private static let senderKey = "From"
    
    /// Key corresponding to `groupMembers` field.
    private static let recipientKey = "To"
    
    /// Default class contructor. Creates a new entry in the database if saved.
    init() {
        super.init(withParseObject: PFObject(className: ParseLocationModel.tableName))
    }
    
    /// Class constructor. Initializes the isntance from a `PFObject`.
    ///
    /// - Parameter withParseObject: The Parse object to tie this model to the Parse database.
    ///
    /// - SeeAlso: PFObject
    override init(withParseObject object: PFObject) {
        super.init(withParseObject: object)
    }

    /// String holding the longitudinal coordinate
    var longitude: String {
        get {
            return parseObject[ParseLocationModel.longitudeKey] as! String
        }
        set {
            parseObject[ParseLocationModel.longitudeKey] = newValue
        }
    }
    
    /// String holding the latitudinal coordinate
    var latitude: String {
        get {
            return parseObject[ParseLocationModel.latitudeKey] as! String
        }
        set {
            parseObject[ParseLocationModel.latitudeKey] = newValue
        }
    }
    
    /// `UserProfileModel` holding the recipient information when the locations are being sent to
	/// parse so that they can be sent encrypted to the intended recipient
    var recipient: UserProfileModel {
        get {
            return self.recipient 
        }
    }
    
    /// This is the Current users' `UserProfileModel` holding the reference for the storage on
	/// parse.
    var sender: UserProfileModel {
        get {
            return self.recipient
        }
    }
	
	/// Fetches all locations sent from storage that were sent to the given user.
	/// 
	/// This is a blocking function that can take a while to complete. This function should not be
	/// called on the UI thread.
	///
	/// - Parameter user: The `ParseUserProfileModel` object for which to fetch `ParseLocationModel`
	///                   objects from storage.
	///
	/// - Returns: An array of `ParseLocationModel` objects if the operation was successful, or
	///            `nil` if the operation was unsuccessful. It is possible for the returned array to
	///            be empty if no matching `ParseLocationModel` objects are found.
	///
	/// - SeeAlso: fetchLocationsForUserInBackground(_:callback:)
    static func fetchLocationsForUser(user: ParseUserProfileModel) throws -> [ParseLocationModel]? {
        // Make sure user profile object is freshly loaded
        try user.load()
        
        // Build query
        let query = PFQuery(className: ParseLocationModel.tableName)
        
        // Execute query, process results
        query.whereKey("To", equalTo: user)
        let parseObjects = try query.findObjects()
        var locations: [ParseLocationModel] = []
        for obj in parseObjects{
            let newLoc = ParseLocationModel(withParseObject: obj)
            locations.append(newLoc)
        }
        
        return locations
    }
    
	/// Fetches all locations sent from storage that were sent to the given user asynchronously.
	///
	/// This function spawns a new thread before executing and returns control to the calling thread
	/// via a call to the optionally provided callback function.
	///
	/// - Parameter user: The `ParseUserProfileModel` object for which to fetch `ParseLocationModel`
	///                   objects from storage.
	/// - Parameter callback: The callback method that will be used to return control to the calling
	///                       thread.
	///
	/// - SeeAlso: fetchLocationsForUser(_:)
    static func fetchLocationsForUserInBackground(user: ParseUserProfileModel, callback: ((result: ParseLocationModel?, error: NSError?) -> Void)?) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let error: NSError? = nil
            let result: ParseLocationModel? = nil
            if let callback = callback {
                callback(result: result, error: error)
            }
        }
    }
}
