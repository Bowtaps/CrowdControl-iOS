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
class ParseUserModel: UserModel {
	
	/// Key corresponding to `username` field
	private static let usernameKey = "username"
	
	/// Key corresponding to `emailVerified` field
	private static let emailVerifiedKey = "emailVerified"
	
	/// Key corresponding to `email` field
	private static let emailKey = "email"
	
	/// Key corresponding to `phone` field
	private static let phoneKey = "phone"
	
	
    /// String containing the current user's username as defined in the
	/// `UserModel` protocol.
    var username: String {
		get {
			return parseObject[usernameKey] as String
		}
	}
	
    /// Boolean to store if the user has verified their email with parse as
	/// defined by the `UserModel` protocol.
	/// 
    /// - Returns: `true` if their email has been verified, `false` if their
	///            email has not been verified.
    var emailVerified: Bool {
		get {
			return parseObject[emailVerifiedKey] as Bool
		}
	}
	
    /// String containing the current users email as defined in the `UserModel`
	/// protocol.
    var email: String {
		get {
			return parseObject[emailKey] as String
		}
		set {
			parseObject[emailKey] = newValue
		}
	}
	
    /// String containing the current users phone nuber as defined in the
	/// `UserModel` protocol.
    var phone: String {
		get {
			return parseObject[phoneKey] as String
		}
		set {
			parseObject[phoneKey] = newValue
		}
	}
	
}