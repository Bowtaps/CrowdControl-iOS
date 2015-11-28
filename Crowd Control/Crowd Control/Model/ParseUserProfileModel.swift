//
//  ParseUserProfileModel.swift
//  CrowdControl
//
//  Created by Daniel Andrus on 2015-11-25
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// This class extends the `ParseBaseModel` class and implements the `UserModel`
/// protocol and is the class to access a user's public profile information
/// from Parse.
class ParseUserProfileModel: ParseBaseModel, UserProfileModel {
	
	/// Parse table name
	private static let tableName = "CCUser"
	
	/// Key corresponding to `displayName` field
	private static let displayNameKey = "DisplayName"
	
	
	
	/// Class constructor. Initializes the isntance from a `PFObject`.
	///
	/// - Parameter withParseObject: The Parse object to tie this model to the
	///                              Parse database.
	///
	/// - SeeAlso: PFObject
	override init(withParseObject object: PFObject) {
		super.init(withParseObject: object)
	}
	
	/// String containing a user's display name as defined in the
	/// `UserProfileModel` protocol.
	var displayName: String {
		get {
			return parseObject[ParseUserProfileModel.displayNameKey] as! String
		}
		set {
			parseObject[ParseUserProfileModel.displayNameKey] = newValue
		}
	}
	
}