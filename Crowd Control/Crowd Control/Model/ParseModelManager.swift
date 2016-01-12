//
//  ParseModelManager.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-28.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// A Parse implementation of the `ModelManager` protocol. Class designed to query Parse for various
/// models, including users and groups.
class ParseModelManager: ModelManager {
	
	/// Current cached active gropu
	private var activeGroup: GroupModel?
	
	/// Compares the submitted username and password to storage and returns a `UserModel` object if
	/// the user was successfully logged in. Otherewise, it throws an exception.
	///
	/// - Parameter username: The username of the user to log in.
	/// - Parameter password: The password to use to log in.
	///
	/// - Returns: A user object if the login was successful.
	func logInUser(username: String, password: String) throws -> UserModel {
		let parseUser = try PFUser.logInWithUsername(username, password: password)
		let user = ParseUserModel(withParseUser: parseUser)
		try user.profile.load()
		return user
	}
	
	/// Compares the submitted username and password to storage on a separate thread, executing the
	/// given callback if successful. If login is unsuccessful, it throws an exception.
	///
	/// - Parameter username: The username of the user to log in.
	/// - Parameter password: The password to use to log in.
	/// - Parameter callback: An optional callback to call once the operation is complete.
	func logInUserInBackground(username: String, password: String, callback: ((user: UserModel?, error: NSError?) -> Void)?) -> Void {
		
		// Set up callbacks so we don't have a billion indentations
		let loadProfileCallback = {
			(profile: BaseModel?, error: NSError?) in
			
			if callback != nil {
				if profile != nil && error == nil {
					callback!(user: self.currentUser(), error: error)
				} else {
					callback!(user: nil, error: error)
				}
			}
		}
		
		let saveProfileCallback = {
			(profile: BaseModel?, error: NSError?) in
			
			if profile != nil && error == nil {
				profile!.loadInBackground(loadProfileCallback)
			} else if callback != nil {
				callback!(user: nil, error: error)
			}
		}
		
		let refreshUserCallback = {
			(user: BaseModel?, error: NSError?) in
			
			if user != nil && error == nil {
				if (user! as! UserModel).profile.modified {
					(user! as! UserModel).profile.saveInBackground(saveProfileCallback)
				} else {
					(user! as! UserModel).profile.loadInBackground(loadProfileCallback)
				}
			} else if callback != nil {
				callback!(user: nil, error: error)
			}
		}
		
		let logInUserCallback = {
			(parseUser: PFUser?, error: NSError?) in
			
			if parseUser != nil && error == nil {
				let user = ParseUserModel(withParseUser: parseUser!)
				user.loadInBackground(refreshUserCallback)
			} else if callback != nil {
				callback!(user: nil, error: error)
			}
		}
		
		// Log in user
		PFUser.logInWithUsernameInBackground(username, password: password, block: logInUserCallback)
		
	}
	
	/// Attempts to create a new user in the system, ensuring that the given username is unique.
	/// Also creates the corresponding user profile object. Both objects are then stored in the
	/// server.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Parameter username: The username of the new user. Must be unique from all other users.
	/// - Parameter password: The password of the new user.
	///
	/// - Returns: The newly created user model if the operation is successful.
	func createUser(username: String, email: String, password: String) throws -> UserModel {
		
		// Create and fill models
		let res = ParseUserModel.createFromSignUp(username, password: password)
		let user = res.user
		let profile = res.profile
		user.email = email
		
		// Save to Parse
		try (user.parseObject as! PFUser).signUp()
		try user.save()
		try profile.save()
		
		// Return final saved model
		return user
	}
	
	/// Attempts to create a new user in the system, ensuring that the given username is unique.
	/// Also creates the corresponding user profile object. Both objects are then stored in the
	/// server.
	///
	/// This is an asynchronous function that will pass control back to the main thread by executing
	/// the given callback prameter if it is not `nil`.
	///
	/// - Parameter username: The username of the new user. Must be unique from all other users.
	/// - Parameter password: The password of the new user.
	/// - Parameter callback: The callback function that will be executed after the operation
	///                       is complete, either successfully or unsuccessfully.
	func createUserInBackground(username: String, email: String, password: String, callback: ((user: UserModel?, error: NSError?) -> Void)?) -> Void {
		
		// Create and fill models
		let res = ParseUserModel.createFromSignUp(username, password: password)
		let user = res.user
		let profile = res.profile
		user.email = email
		
		// Create callbacks to avoid stupid nesting
		let profileSaveCallback = {
			(model: BaseModel?, error: NSError?) in
			if callback != nil {
				if model != nil && error == nil {
					callback!(user: user, error: error)
				} else {
					callback!(user: nil, error: error)
				}
			}
		}
		
		let userSaveCallback = {
			(model: BaseModel?, error: NSError?) in
			if model != nil && error == nil {
				profile.saveInBackground(profileSaveCallback)
			} else if callback != nil {
				callback!(user: nil, error: error)
			}
		}
		
		let signupCallback = {
			(succeed: Bool, error: NSError?) in
			if succeed && error != nil {
				user.saveInBackground(userSaveCallback)
			} else if callback != nil {
				callback!(user: nil, error: error)
			}
		}
		
		// Kick off the multiple asynchronous tasks
		(user.parseObject as! PFUser).signUpInBackgroundWithBlock(signupCallback)
		
	}

	/// Retrieves the currently logged-in user. If no user is logged in, returns `nil`.
	///
	/// - Returns: The current user if one is logged in, or `nil` if no user is logged in.
	func currentUser() -> UserModel? {
		if let user = PFUser.currentUser() {
			return ParseUserModel(withParseUser: user)
		} else {
			return nil
		}
	}
	
	/// Logs out the currently logged in user, removing them from any caches and returning whether
	/// or not the operation was successful.
	///
	/// - Returns: true if the operation was successful and the user was successfully logged out,
	///            false if not.
	func logOutCurrentUser() -> Bool {
		if currentUser() == nil {
			return false
		} else {
			PFUser.logOut()
			return true
		}
	}
	
	/// Fetches all groups in storage synchronously.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Returns: Array of group models in storage.
	func fetchGroups() throws -> [GroupModel] {
		var groups: [GroupModel] = []
		let parseGroups = try ParseGroupModel.getAll()
		for parseGroup in parseGroups {
			groups.append(parseGroup as GroupModel)
		}
		return groups
	}
	
	/// Fetches all gropus in storage asynchronously.
	///
	/// This is an asynchronous function that will pass control back to the main thread by executing
	/// the given callback parameter if it is not `nil`.
	///
	/// - Parameter callback: The callback function that will be executed after the operation is
	///                       complete, either successfully or unsuccessfully.
	func fetchGroupsInBackground(callback: ((results: [GroupModel]?, error: NSError?) -> Void)?) -> Void {
		ParseGroupModel.getAllInBackground {
			(results: [ParseGroupModel]?, error: NSError?) -> Void in
			if callback != nil {
				if results == nil {
					callback!(results: nil, error: error)
				} else {
					var groups: [GroupModel] = []
					for result in results! {
						groups.append(result as GroupModel)
					}
					callback!(results: groups, error: error)
				}
			}
		}
	}
	
	/// Gets the cached currently active group of which the current user is member, if any. If no
	/// user is logged in or the logged in user is not a member of any groups, this method will
	/// return `nil`. This function does not access storage in any way.
	///
	/// This method deals exclusively with cached values. In order to update the cached value,
	/// either set the cached value directly using `setCurrentGroup(_:)` or allowing it to be set
	/// automatically using `fetchCurrentGroup()->GroupModel?` and
	/// `fetchCurrentGroupInBackground(_:)`.
	///
	/// - Returns: The group of which the logged in user (if any) is a member of, or `nil` if no
	///            such group exists.
	func currentGroup() -> GroupModel? {
		return activeGroup
	}
	
	/// Sets the current cached value of the active group. Set the value to `nil` to indicate that
	/// there are no currently active groups. This function does not modify storage in anyway.
	///
	/// - Parameter group: The current active group, or `nil` if no groups are currently active.
	func setCurrentGroup(group: GroupModel?) {
		self.activeGroup = group
	}
	
	/// Gets the current active group from storage. If a user is currently logged in and is member
	/// of a group, this function will find that group and return it, or will return `nil` if no
	/// such group exists or if no user is logged in. The results of this function are cached and
	/// can be accessed with a call to `currentGroup()`.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Returns: The active group or nil if no group is active.
	func fetchCurrentGroup() throws -> GroupModel? {
		if let user = currentUser(), profile = user.profile as? ParseUserProfileModel {
			let group = try ParseGroupModel.getGroupContainingUser(profile) as GroupModel?
			setCurrentGroup(group)
			return group
		} else {
			return nil
		}
	}
	
	/// Gets the current active group from storage asynchronously. If a user is currently logged in
	/// and is a member of a group, this function will find that group and return it. If no such
	/// group can be found or no user is logged in, then this function will return `nil`. The
	/// results of this function are cached and can be accessed with a call to `currentGroup()`.
	///
	/// This is an asynchronous function that will pass control back to the main thread by executing
	/// the given callback parameter if it is not `nil`.
	///
	/// - Parameter callback: The callback function that will be executed after the operation is
	///                       complete, either successfully or unsuccessfully.
	func fetchCurrentGroupInBackground(callback: ((result: GroupModel?, error: NSError?) -> Void)?) -> Void {
		if let user = currentUser(), profile = user.profile as? ParseUserProfileModel {
			ParseGroupModel.getGroupContainingUserInBackground(profile) {
				(result: ParseGroupModel?, error: NSError?) -> Void in
				let group = result as? GroupModel
				if error == nil {
					self.setCurrentGroup(group)
				}
				if let callback = callback {
					callback(result: group, error: error)
				}
			}
		} else if let callback = callback {
			callback(result: nil, error: nil)
		}
	}
	
}
