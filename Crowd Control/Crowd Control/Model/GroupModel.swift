//
//  GroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/24/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

//Structure to hold the waypoint object for location and a message
struct Waypoint {
    var waypointId: Int
    var longitude: Double
    var latitude: Double
    var message: String
}

protocol GroupModel: BaseModel{
    var generalLocation: PFGeoPoint {get set}
    var groupDescription: String {get set}
    var groupName: String {get set}
    var groupMembers: [UserProfileModel] {get}
	var groupLeader: UserProfileModel? {get set}
	
	func addGroupMember(member: UserProfileModel) -> Bool
	func removeGroupMember(member: UserProfileModel) -> Bool
}