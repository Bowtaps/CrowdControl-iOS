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
	/// the given callback prameter if it is not `nil`.
	///
	/// - Parameter username: The username of the new user. Must be unique from all other users.
	/// - Parameter password: The password of the new user.
	/// - Parameter callback: The callback function that will be executed after the operation
	///                       is complete, either successfully or unsuccessfully.
	func createUserInBackground(username: String, email: String, password: String, callback: ((user: UserModel?, error: NSError?) -> Void)?) -> Void
	
	/// Retrieves the currently logged-in user. If no user is logged in, returns `nil`.
	///
	/// - Returns: The current user if one is logged in, or `nil` if no user is logged in.
	func currentUser() -> UserModel?
	
	/// Fetches all groups in storage synchronously.
	///
	/// This is a blocking function that can take several seconds to complete. If an operation
	/// fails, then an exception will be thrown.
	///
	/// - Returns: Array of group models in storage.
	func fetchGroups() throws -> [GroupModel]
	
}
