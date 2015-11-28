//
//  ParseBaseModel.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-25
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// The core Parse implementation for models. Implements the BaseModel protocol
/// and provies functionality to access the basic information about the model,
/// such as:
/// 
/// - Unique identifier
/// - Creation timestamp
/// - Last updated timestamp
/// - Flag indicating modification since last save
/// - Methods for loading from and saving to storage
class ParseBaseModel: BaseModel {
	
	/// Key corresponding to `id` field
	private static let idKey = "objectId"
	
	/// Key corresponding to `created` field
	private static let createdKey = "createdAt"
	
	/// Key corresponding to `updated` field
	private static let updatedKey = "updatedAt"
	
	
	
	/// Internal reference to the Parse API object representing this object in
	/// the remote database.
	let parseObject: PFObject
	
	
	
	/// Class constructor. Initializes the instance from a `PFObject`.
	/// 
	/// - Parameter withParseObject: The Parse object to tie this model to the Parse
	///                              Parse database.
	/// 
	/// - SeeAlso PFObject
	init(withParseObject object: PFObject) {
		parseObject = object
	}
	
	
	
	/// Read-only computed value representing the ID of the object as defined in
	/// the `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.id
	var id: String {
		get {
			return parseObject[ParseBaseModel.idKey] as! String
		}
	}
	
	/// Read-only computed value for the timestamp when this object was
	/// initially created as defined in the `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.created
	var created: NSDate {
		get {
			return parseObject.createdAt!
		}
	}
	
	/// Read-only computed value for the timestamp when this object was
	/// last updated on the server as defined in the `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.updated
	var updated: NSDate {
		get {
			return parseObject.updatedAt!
		}
	}
	
	/// Read-only computed value indicating whether or not the data contained
	/// in this model is "dirty", which is to say that this model contains
	/// changes that have not been saved to the server.
	/// 
	/// - SeeAlso: BaseModel.modified
	var modified: Bool {
		get {
			return parseObject.isDirty()
		}
	}
	
	
	
	/// Reloads this object from Parse as defined by the `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.load()
	func load() throws {
		try parseObject.fetch()
	}
	
	/// Reloads this object from Parse asynchronously as defined by the
	/// `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.loadInBackground(_:)
	func loadInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?) {
		parseObject.fetchInBackgroundWithBlock {
			(object: PFObject?, error: NSError?) -> Void in
			if callback != nil {
				callback!(object: self, error: error)
			}
		}
	}
	
	/// Saves this object to Parse as defined by the `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.save()
	func save() throws {
		try parseObject.save()
	}
	
	/// Saves this object to Parse as defined by the `BaseModel` protocol.
	/// 
	/// - SeeAlso: BaseModel.saveInBackground(_:)
	func saveInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?) {
		parseObject.saveInBackgroundWithBlock {
			(succeeded: Bool, error: NSError?) -> Void in
			if callback != nil {
				callback!(object: self, error: error)
			}
		}
	}
	
}
