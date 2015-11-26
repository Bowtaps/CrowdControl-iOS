//
//  ParseBaseModel.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-25
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

class ParseBaseModel: BaseModel {
	
	private static let keyId = "objectId"
	private static let createdKey = "createdAt"
	private static let updatedKey = "updatedKey"
	
	let parseObject: PFObject?
	
	
	
	var id: String? {
		get {
			return parseObject?[idKey] as? String
		}
	}
	
	var created: NSDate? {
		get {
			return parseObject?.createdAt
		}
	}
	
	var updated: NSDate? {
		get {
			return parseObject?.updatedAt
		}
	}
	
	var modified: Bool {
		get {
			if let parseObject = parseObject? {
				return parseObject.dirty
			} else {
				return false
			}
		}
	}
	
	
	
	func load() {
		if let parseObject = parseObject? {
			parseObject.fetch()
		}
	}
	
	func loadInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?) {
		if let parseObject = parseObject? {
			parseObject.fetchInBackgroundWithBlock {
				(object: PFObject?, error: NSError?) -> Void in
				if callback != nil {
					callback!(object: self, error: error)
				}
			}
		} else if callback != nil {
			callback!(object: nil, error: nil)
		}
	}
	
	func save() {
		if let parseObject = parseObject? {
			parseObject.save()
		}
	}
	
	func saveInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?) {
		if let parseObject = parseObject? {
			parseObject.saveInBackgroundWithBlock {
				(object: PFObject?, error: NSError?) -> Void in
				if callback != nil {
					callback!(object: self, error: error)
				}
			}
		} else if callback != nil {
			callback!(object: nil, error: nil)
		}
	}
	
	
}
