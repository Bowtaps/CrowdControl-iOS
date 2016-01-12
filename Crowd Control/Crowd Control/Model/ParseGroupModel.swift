//
//  ParseGroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/31/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// The Parse implementation of the `GroupModel` protocol. Extends `ParseBaseModel` class and
/// implements the `GroupModel` protocol and is designed to allow access to a group's information,
/// including the group members, gropu name, and group description.
class ParseGroupModel: ParseBaseModel, GroupModel {
	
    /// Parse table name.
    private static let tableName = "Group"
    
    /// Key corresponding to 'generalLocation' field.
    private static let generalLocationKey = "GeneralLocation"
    
    /// Key corresponding to `groupDescription` field.
    private static let groupDescriptionKey = "GroupDescription"
    
    /// Key corresponding to `groupName` field.
    private static let groupNameKey = "GroupName"
    
    /// Key corresponding to `groupMembers` field.
    private static let groupMembersKey = "GroupMembers"
	
	/// Key corresponding to `groupLeader` field
	private static let groupLeaderKey = "GroupLeader"
    
    /// Default class contructor. Creates a new entry in the database if saved.
    init() {
        super.init(withParseObject: PFObject(className: ParseGroupModel.tableName))
    }
    
    /// Class constructor. Initializes the isntance from a `PFObject`.
    ///
    /// - Parameter withParseObject: The Parse object to tie this model to the
    ///                              Parse database.
    ///
    /// - SeeAlso: PFObject
    override init(withParseObject object: PFObject) {
        super.init(withParseObject: object)
    }
    
    /// PFGeoPoint Object to store the groups general location.  This field is used for
    /// looking up groups as well as future support with finding ads by location
    /// 
    /// - SeeAlso: PFGeoPoint
    var generalLocation: PFGeoPoint {
        get {
            return parseObject[ParseGroupModel.generalLocationKey] as! PFGeoPoint
        }
        set {
            parseObject[ParseGroupModel.generalLocationKey] = newValue
        }
    }
	
    /// String to hold the description of the group.
    var groupDescription: String {
        get {
            return parseObject[ParseGroupModel.groupDescriptionKey] as! String
        }
        set {
            parseObject[ParseGroupModel.groupDescriptionKey] = newValue
        }
    }
	
    /// String to hold the Name of the group.
    var groupName: String {
        get {
            return parseObject[ParseGroupModel.groupNameKey] as! String
        }
        set {
            parseObject[ParseGroupModel.groupNameKey] = newValue
        }
    }
	
	/// An array of `UserProfileModel` objects to keep track of the members of the group.
    var groupMembers: [UserProfileModel] {
        get {
			var members: [UserProfileModel] = []
			for cachedMember in cachedGroupMembers {
				members.append(ParseUserProfileModel.init(withParseObject: cachedMember) as UserProfileModel)
			}
            return members
        }
    }
	
	/// The `UserProfileModel` object who is the designated leader of the group.
	var groupLeader: UserProfileModel? {
		get {
			if let parseObject = parseObject[ParseGroupModel.groupLeaderKey] as? PFObject {
				return ParseUserProfileModel.init(withParseObject: parseObject)
			} else {
				return nil
			}
		}
		set {
			if newValue == nil {
				parseObject[ParseGroupModel.groupLeaderKey] = nil
			} else if let newValue = newValue as? ParseUserProfileModel {
				parseObject[ParseGroupModel.groupLeaderKey] = newValue.parseObject
			}
		}
	}
	
	
	
	/// An internal cache of members of this group stored as their base Parse Objects.
	private var cachedGroupMembers: [PFObject] = []
	
	/// Method for adding a user as a member of the group. Model must be saved afterwards, as this
	/// method does not automatically save the model.
	func addGroupMember(member: UserProfileModel) -> Bool {
		let member = member as! ParseUserProfileModel
		
		// Make sure user isn't already a member of the group
		for cachedMember in cachedGroupMembers {
			if cachedMember == member.parseObject {
				return false
			}
		}
		
		// Add parse object to relation, making them a member of this group
		let relation = parseObject.relationForKey(ParseGroupModel.groupMembersKey)
		relation.addObject(member.parseObject)
		
		// Update the cache
		cachedGroupMembers.append(member.parseObject)
		
		return true
	}
	
	/// Method for removing a user from the group. Model must be saved afterwards, as this method
	/// does not automatically save the model.
	func removeGroupMember(member: UserProfileModel) -> Bool {
		let member = member as! ParseUserProfileModel
		
		// Make sure user is already a member of the group
		var cachedIndex = -1
		var found = false
		for (index, cachedMember) in cachedGroupMembers.enumerate() {
			if cachedMember == member.parseObject {
				found = true
				cachedIndex = index
				break
			}
		}
		if found == false {
			return false
		}
		
		// Remove parse object from relation, removing them from the group
		let relation = parseObject.relationForKey(ParseGroupModel.groupMembersKey)
		relation.removeObject(member.parseObject)
		
		// Update the cache
		cachedGroupMembers.removeAtIndex(cachedIndex)
		
		return true
	}
	
	/// Loads this object from Parse storage synchronously. In addition to the normal functionality
	/// inherited from `ParseBaseModel`, this function also fetches and caches the users who are
	/// members of this group.
	///
	/// - SeeAlso: `ParseBaseModel.load()`
	override func load() throws {
		try super.load()
		
		// Fetch objects in relation
		let query = parseObject.relationForKey(ParseGroupModel.groupMembersKey).query()
		
		// Cache objects in relation
		if let members = try query?.findObjects() {
			cachedGroupMembers = members
		}
	}
	
	/// Loads this object from Parse storage asynchronously. In addition to the normal functionality
	/// inherited from `ParseBaseModel`, this function also fetches and caches the users who are
	/// members of this group.
	///
	/// - SeeAlso: `ParseBaseModel.loadInBackground(_:)`
	override func loadInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?) {
		super.loadInBackground {
			(object: BaseModel?, error: NSError?) -> Void in
			
			if object == nil || error != nil {
				
				// Detect and handle errors
				if let callback = callback {
					callback(object: self, error: error)
				}
				
			} else {
				
				// Fetch group members asynchronously
				let query = self.parseObject.relationForKey(ParseGroupModel.groupMembersKey).query()
				query?.findObjectsInBackgroundWithBlock() {
					(objects: [PFObject]?, error: NSError?) -> Void in
					
					// Cache results
					if objects != nil && error == nil {
						if let members = objects {
							self.cachedGroupMembers = members
						}
					}
					
					// Pass control back to main thread
					if let callback = callback {
						callback(object: self, error: error)
					}
				}
			}
		}
	}
	
    /// Function to create a group if there is not one that exists
    /// - Parameter name: String containing the group name
    /// - Parameter description: String containing the description of the group
    ///
    /// - Returns: Object of type ParseGroupModel that contains the information
    static func createGroup(name: String, description: String) -> ParseGroupModel {
		let group = PFObject(className: ParseGroupModel.tableName)
        group[self.groupNameKey] = name
        group[self.groupDescriptionKey] = description
        //group[self.groupMembersKey] = members
        group.saveInBackground()
        let newGroup = ParseGroupModel(withParseObject: group)
        return newGroup
    }
	
	/// Fetches all groups in storage synchronously.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Returns: Array of group models in storage.
	static func getAll() throws -> [ParseGroupModel] {
		var result: [ParseGroupModel] = []
		let query = PFQuery(className: ParseGroupModel.tableName)
		
		let parseObjects = try query.findObjects()
		for parseObject in parseObjects {
			result.append(ParseGroupModel(withParseObject: parseObject))
		}
		
		return result
	}
	
	/// Fetches all groups in Parse storage asynchronously, returning control to the main thread
	/// through the provided callback (if any).
	///
	/// - Parameter callback: Optional closure that will be called on completion or if an error
	///                       is encountered.
	static func getAllInBackground(callback: ((results: [ParseGroupModel]?, error: NSError?) -> Void)?) {
		let query = PFQuery(className: ParseGroupModel.tableName)
		query.findObjectsInBackgroundWithBlock {
			(objects: [PFObject]?, error: NSError?) -> Void in
			if callback != nil {
				if objects == nil {
					callback!(results: nil, error: error)
				} else {
					var groups: [ParseGroupModel] = []
					for object in objects! {
						groups.append(ParseGroupModel(withParseObject: object))
					}
					callback!(results: groups, error: error)
				}
			}
		}
	}
	
	/// Fetches the first group to which the provided user belongs, if any. If no group is found
	/// that contains the provided user, then `nil` is returned.
	///
	/// This is a blocking function and should be executed on a thread separate from the main
	/// thread. See `getGroupContainingUserInBackground(_:,_:)` for fetching on a separate thread.
	/// This function will throw an exception if an error occurs.
	///
	/// - Parameter user: The user to search for.
	/// 
	/// - Returns: Optional `ParseGroupModel` object that has `user` as a member, or `nil` if no
	///            such group could be found. This object will be fully loaded from storage such
	///            that a call to `ParseGroupModel.load()` is not necessary.
	///
	/// - SeeAlso: `getGroupContainingUserInBackground(_:,_:)`
	static func getGroupContainingUser(user: ParseUserProfileModel) throws -> ParseGroupModel? {
		
		// Make sure user profile object is freshly loaded
		try user.load()
		
		// Build query
		let query = PFQuery(className: ParseGroupModel.tableName)
		
		// Placeholder if matching group is found
		var parseObject: PFObject? = nil
		
		// Execute query, process results
		let parseObjects = try query.findObjects()
		for pObject in parseObjects {
			
			// Search members for match with given user
			if let subquery = pObject.relationForKey(ParseGroupModel.groupMembersKey).query() {
				subquery.whereKey("objectId", equalTo: user.id)
				subquery.limit = 1
				
				// Execute subquery and check for match
				let parseUsers = try subquery.findObjects()
				if parseUsers.count > 0 {
					parseObject = pObject
					break
				}
			}
		}
		
		// If a match is found, build GroupModel and return it
		if let parseObject = parseObject {
			let group = ParseGroupModel.init(withParseObject: parseObject)
			try group.load()
			return group
		} else {
			return nil
		}
	}
	
	/// Fetches the first group to which the provided user belongs, if any. If no group is found
	/// that contains the provided user, then `nil` is returned.
	///
	///	This function spawns a new thread for querying storage. After successful execution or if an
	/// error occurs, this function passes control back to the main thread by calling the closure
	/// that was optionally passed as an argument.
	///
	/// - Parameter user: The user to search for.
	/// - Parameter callback: Optional callback function to call after successful execution or if an
	///                       error occurs. If `nil` is provided, then the callback will not be
	///                       called.
	///
	/// - SeeAlso: `getGroupContainingUser(_:)`
	static func getGroupContainingUserInBackground(user: ParseUserProfileModel, callback: ((result: ParseGroupModel?, error: NSError?) -> Void)?) {
		
		let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
		dispatch_async(dispatch_get_global_queue(priority, 0)) {
			
			var err: NSError? = nil
			var group: ParseGroupModel? = nil
			
			do {
				group = try getGroupContainingUser(user)
			} catch {
				err = error as NSError
			}
			
			dispatch_async(dispatch_get_main_queue()) {
				if let callback = callback {
					callback(result: group, error: err)
				}
			}
		}
	}
}
