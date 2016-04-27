//
//  GroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/24/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

/// Object to store group waypoints location and message
struct Waypoint {
    /// Waypoint's unique id to be generated on creation
    var waypointId: Int
    /// Waypoint longitude
    var longitude: Double
    /// Waypoint latitude
    var latitude: Double
    /// Message to display at location
    var message: String
}

/// Model protocol representing a group of users using the app. This model contains data accessible
/// to all users of the app, including group name, group description, group leader, and members of
/// the group. This model does not provide direct access to messages related to the group, nor does
/// does it allow access to member locations, although it does provide a generic group location.
protocol GroupModel: BaseModel{
	
	/// Group's general location, used for location filtering
    var generalLocation: PFGeoPoint {get set}
	
	/// Group description set by the group leader during creation
    var groupDescription: String {get set}
	
	/// Group name set by the group leader during creation
    var groupName: String {get set}
	
	/// List of users who are members of the group. This property can only be modified by the
	/// `addGroupMember(_:)` and `removeGroupMember(_:)` methods.
    var groupMembers: [UserProfileModel] {get}
	
	/// The user who is the designated leader of the group, usually the user who created the group.
	var groupLeader: UserProfileModel? {get set}
	
	/// Method for adding a user as a member of the group. Model must be saved afterwards, as this
	/// method does not automatically save the model.
	func addGroupMember(member: UserProfileModel) -> Bool
	
	/// Method for removing a user from the group. Model must be saved afterwards, as this method
	/// does not automatically save the model.
	func removeGroupMember(member: UserProfileModel) -> Bool
	
}