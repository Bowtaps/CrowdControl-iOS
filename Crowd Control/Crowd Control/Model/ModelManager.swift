//
//  ModelManager.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-28.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

/// A class dedicated for providing model functionality that does not belong in any individual
/// model, such as logging users in, signing up new users, or getting the currrent user.
protocol ModelManager {
	
	/// Compares the submitted username and password to storage and returns a `UserModel` object if
	/// the user was successfully logged in. Otherewise, it throws an exception.
	/// 
	/// - Parameter username: The username of the user to log in.
	/// - Parameter password: The password to use to log in.
	///
	/// - Returns: A user object if the login was successful.
	func logInUser(username: String, password: String) throws -> UserModel
	
	/// Compares the submitted username and password to storage on a separate thread, executing the
	/// given callback if successful. If login is unsuccessful, it throws an exception.
	/// 
	/// - Parameter username: The username of the user to log in.
	/// - Parameter password: The password to use to log in.
	/// - Parameter callback: An optional callback to call once the operation is complete.
	func logInUserInBackground(username: String, password: String, callback: ((user: UserModel?, error: NSError?) -> Void)?) -> Void
	
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
	func createUser(username: String, email: String, password: String) throws -> UserModel
	
	/// Attempts to create a new user in the system, ensuring that the given username is unique.
	/// Also creates the corresponding user profile object. Both objects are then stored in the
	/// server.
	///
	/// This is an asynchronous function that will pass control back to the main thread by executing
	/// the given callback parameter if it is not `nil`.
	///
	/// - Parameter username: The username of the new user. Must be unique from all other users.
	/// - Parameter password: The password of the new user.
	/// - Parameter callback: The callback function that will be executed after the operation is
	///                       complete, either successfully or unsuccessfully.
	func createUserInBackground(username: String, email: String, password: String, callback: ((user: UserModel?, error: NSError?) -> Void)?) -> Void
	
	/// Retrieves the currently logged-in user. If no user is logged in, returns `nil`.
	///
	/// - Returns: The current user if one is logged in, or `nil` if no user is logged in.
	func currentUser() -> UserModel?
	
	/// Logs out the currently logged in user, removing them from any caches and returning whether
	/// or not the operation was successful.
	///
	/// - Returns: true if the operation was successful and the user was successfully logged out,
	///            false if not.
	func logOutCurrentUser() -> Bool
	
	/// Fetches all groups in storage synchronously.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Returns: Array of group models in storage.
	func fetchGroups() throws -> [GroupModel]
	
	/// Fetches all gropus in storage asynchronously.
	///
	/// This is an asynchronous function that will pass control back to the main thread by executing
	/// the given callback parameter if it is not `nil`.
	///
	/// - Parameter callback: The callback function that will be executed after the operation is
	///                       complete, either successfully or unsuccessfully.
	func fetchGroupsInBackground(callback: ((results: [GroupModel]?, error: NSError?) -> Void)?) -> Void
	
	/// Gets the cached currently active group of which the current user is member, if any. If no
	/// user is logged in or the logged in user is not a member of any groups, this method will
	/// return `nil`. This function does not access storage in any way.
	///
	/// This method deals exclusively with cached values. In order to update the cached value,
	/// either set the cached value directly using `setCurrentGroup(_:)` or allowing it to be set
	/// automatically using `fetchCurrentGroup()` and `fetchCurrentGroupInBackground(_:)`.
	///
	/// - Returns: The `GroupModel` of which the logged in user (if any) is a member of, or `nil` if
	///            no such group exists.
	func currentGroup() -> GroupModel?
	
	/// Sets the current cached value of the active group. Set the value to `nil` to indicate that
	/// there are no currently active groups. This function does not modify storage in anyway.
	///
	/// - Parameter group: The current active `GroupModel`, or `nil` if no groups are currently
	///                    active.
	func setCurrentGroup(group: GroupModel?)
	
	/// Gets the current active group from storage. If a user is currently logged in and is member
	/// of a group, this function will find that group and return it, or will return `nil` if no
	/// such group exists or if no user is logged in. The results of this function are cached and
	/// can be accessed with a call to `currentGroup()`.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Returns: The active `GroupModel` or `nil` if no group is active.
	func fetchCurrentGroup() throws -> GroupModel?
	
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
	func fetchCurrentGroupInBackground(callback: ((result: GroupModel?, error: NSError?) -> Void)?) -> Void
	
}
