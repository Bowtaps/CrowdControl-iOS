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
protocol UserModel: BaseModel {
	
	/// String containing the user's login username. May be `nil` if this value has not been set.
	var username: String {get}
	
	/// Boolean indicating whether or not the user has successfully completed the email verification
	/// process. May be `nil` if this value has not been set.
	var emailVerified: Bool {get}
	
	/// String containing the email address of the user. May be `nil` if this value has not been
	/// set.
	var email: String {get set}
	
	/// String containing the phone number of the user. May be `nil` if this value has not been set.
	var phone: String {get set}
	
}
