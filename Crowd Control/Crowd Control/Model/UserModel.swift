//
//  UserModel.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-24.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

/// Model protocol representing a user who is using the app. This model is not intended to represent
/// any user other than the one currently using the device, as it contains information that should
/// not be shared with users other than the owner of the data.
protocol UserModel {
	
	/// The ID of the object as determined by remote storage. This value is automatically generated
	/// when the object is stored and is usually determined by a remote server. It is valid for this
	/// value to be nil, and thus should be used with care and only if absolutely necessary.
	var id: String? {get}
	
	/// String containing the user's login username. May be `nil` if this value has not been set.
	var username: String? {get}
	
	/// Boolean indicating whether or not the user has successfully completed the email verification
	/// process. May be `nil` if this value has not been set.
	var emailVarified: Bool? {get}
	
	/// String containing the email address of the user. May be `nil` if this value has not been
	/// set.
	var email: String? {get set}
	
	/// String containing the phone number of the user. May be `nil` if this value has not been set.
	var phone: String? {get set}
	
	/// Timestamp of when this object was first created and stored. This value may be automatically
	/// determined by the server if the model is using a remote machine for storage.
	var created: NSDate? {get}
	
	/// Timestamp of the last time this object was updated in storage. This value may be
	/// automatically determined by the server if the model is using a remote machine for storage.
	var updated: NSDate? {get}
	
	/// Flag indicating whether or not this object has been modified since it was last pulled from
	/// or pushed to storage.
	var modified: Bool {get}
	
	
	
	/// Loads this object from storage, either local or remote as determined by the implementation.
	/// 
	/// This is a blocking function and should be executed on a thread separate from the main
	/// thread. See `loadInBackground()` for loading this object on a separate thread. This function
	/// will throw an exception if an error occurs.
	/// 
	/// - SeeAlso: `loadInBackground(_:)`
	func load()
	
	/// Loads this object from storage, either local or remote as determined by the implementation.
	///
	/// This function spawns a new thread and reloads this object from storage. After successful
	/// execution or if an error occurs, this function passes control back to the main thread by
	/// calling the closure that was optionally passed as an argument.
	/// 
	/// - Parameter callback: Optional callback function to call after successful execution or if an
	///                       error occurs. If `nil` is provided, then the callback will not be
	///                       called.
	/// 
	/// - SeeAlso: `load()`
	func loadInBackground(callback: ((object: UserModel?, error: NSError?) -> Void)?)
	
	/// Saves this object storage, either local or remote as determined by the implementation.
	/// 
	/// This is a blocking function and should be executed on a thread separate from the main
	/// thread. See `saveInBackground()` for saving this object on a separate thread. This function
	/// will throw an exception if an error occurs.
	/// 
	/// - SeeAlso: `saveInBackground(_:)`
	func save()
	
	/// Saves this object to storage, either local or remote as determined by the implementation.
	/// 
	/// This function spawns a new thread and sends this object to storage. After successful
	/// execution or if an error occurs, this function passes control back to the main thread by
	/// calling the closure that was optionally passed as an argument.
	/// 
	/// - Parameter callback: Optional callback function to call after successful execution or if an
	///                       error occurs. If `nil` is provided, then the callback will not be
	///                       called.
	/// 
	/// - SeeAlso: `save()`
	func saveInBackground(callback: ((object: UserModel?, error: NSError?) -> Void)?)
	
}
