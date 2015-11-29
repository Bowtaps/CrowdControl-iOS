//
//  ParseUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/28/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// This class extends the `ParseBaseModel` class and implements the `UserModel`
/// protocol and is the class to access the current user's information from
/// Parse.
class ParseUserModel: ParseBaseModel, UserModel {
	
	/// Parse table name.
	private static let tableName = "_User"
	
	/// Key corresponding to `username` field.
	private static let usernameKey = "username"
	
	/// Key corresponding to `emailVerified` field.
	private static let emailVerifiedKey = "emailVerified"
	
	/// Key corresponding to `email` field.
	private static let emailKey = "email"
	
	/// Key corresponding to `phone` field.
	private static let phoneKey = "phone"
	
	/// Key corrresponding to `profile` field.
	private static let profileKey = "CCUser"
	
	
	
	/// The model corresponding to this user's public profile.
	let profile: UserProfileModel
	
	
	
	/// Class constructor. Initializes the instance from a `PFObject`.
	///
	/// - Parameter withParseUser: The Parse user to tie this model to the
	///                            Parse database.
	/// - Parameter profile: An optional user profile model to connect to this user. If no value is
	///                      or `nil` is provided, this constructor will attempt to get the profile
	///						 from the `withParseUser` model.
	///
	/// - SeeAlso: PFObject
	init(withParseUser user: PFUser, profile: UserProfileModel? = nil) {
		if let profile = profile {
			self.profile = profile
		} else {
			self.profile = ParseUserProfileModel(withParseObject: user[ParseUserModel.profileKey] as! PFObject)
		}
		super.init(withParseObject: user)
	}
	
	
	
    /// String containing the current user's username as defined in the
	/// `UserModel` protocol.
    var username: String {
		get {
			return (parseObject as! PFUser).username!
		}
	}
	
    /// Boolean to store if the user has verified their email with parse as
	/// defined by the `UserModel` protocol.
	/// 
    /// - Returns: `true` if their email has been verified, `false` if their
	///            email has not been verified.
    var emailVerified: Bool {
		get {
			return parseObject[ParseUserModel.emailVerifiedKey] as! Bool
		}
	}
	
    /// String containing the current users email as defined in the `UserModel`
	/// protocol.
    var email: String {
		get {
			return (parseObject as! PFUser).email!
		}
		set {
			(parseObject as! PFUser).email = newValue
		}
	}
	
    /// String containing the current users phone nuber as defined in the
	/// `UserModel` protocol.
    var phone: String {
		get {
			return parseObject[ParseUserModel.phoneKey] as! String
		}
		set {
			parseObject[ParseUserModel.phoneKey] = newValue
		}
	}
	
	
	
	/// Main function for creating a new user. Automatically creates a corresponding user profile
	/// and returns both in a tuple.
	/// 
	/// - Note: Both returned objects must be saved individually before they are added to the
	///         database.
	///
	/// - Parameter username: The new user's username.
	/// - Parameter password: The new user's password.
	///
	/// - Returns: A tuple containing the newly created user object and its corresponding profile.
	static func createFromSignUp(username: String, password: String) -> (user: ParseUserModel, profile: ParseUserProfileModel) {
		
		// Create new profile object
		let profile = ParseUserProfileModel()
		
		// Create new user object
		let parseUser = PFUser()
		parseUser.username = username
		parseUser.password = password
		parseUser[profileKey] = profile.parseObject
		
		// Now create a UserModel
		let user = ParseUserModel(withParseUser: parseUser, profile: profile)
		return (user, profile)
	}
	
}
