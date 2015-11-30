//
//  UserProfileModel.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-24.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

/// Model protocol representing the public profile of any user in the app. This model is intended to
/// be an adequate interface for interacting with other users of the app, as it contains sufficient
/// information about the other user to communicate with them.
protocol UserProfileModel: BaseModel {
	
	/// The outward-facing display name of the other user. May be `nil` if this value has not been
	/// set. This value is not unique to users an should *never* be used as an index or identifier.
	/// This value can and should, however, be used in the following capacities:
	///
	/// - Displayed as a label identifying the user to other users
	/// - Returned as a search result when and if searching for users is ever performed
	var displayName: String {get set}
	
}
