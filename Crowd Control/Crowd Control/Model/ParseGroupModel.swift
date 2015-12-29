//
//  ParseGroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/31/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

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
            return parseObject[ParseGroupModel.groupMembersKey] as! [UserProfileModel]
        }
    }
	
	/// The `UserProfileModel` object who is the designated leader of the group
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
	
    /// Function to create a group if there is not one that exists
    /// - Parameter name: String containing the group name
    /// - Parameter description: String containing the description of the group
    ///
    /// - Returns: Object of type ParseGroupModel that contains the information
    static func createGroup(name: String, description: String) -> ParseGroupModel {
        let group = PFObject(className: "Group")
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
}
