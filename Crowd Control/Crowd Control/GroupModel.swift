//
//  GroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/24/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

//Structure to hold the waypoint object for location and a message
struct Waypoint {
    var waypointId: Int
    var longitude: Double
    var latitude: Double
    var message: String
}

protocol GroupModel {
    var groupLeader: String {get set}
    var groupName: String {get set}
    //Itinerary is currently set to string to use as a place holder until we know
    //what the data type looks like
    var itinerary: [String]? {get set}
    var status: String? {get set}
    var waypoints: [Waypoint]? {get set}
    var groupMembers: [String] {get set}
    
    func addGroupMember(member: String)
    func addItineraryItem(itineraryItem: String)
    func addWaypoint(waypoint: Waypoint)
    func removeGroupMember(member: String)
}

extension GroupModel{
    mutating func addGroupMember(member: String){
        self.groupMembers += [member]
    }
    mutating func addItineraryItem(itineraryItem: String){
        if self.itinerary == nil {
            self.itinerary = [itineraryItem]
        }
        else {
            self.itinerary! += [itineraryItem]
        }
    }
    mutating func addWaypoint(waypoint: Waypoint){
        if self.waypoints == nil {
            self.waypoints! = [waypoint]
        }else{
            self.waypoints! += [waypoint]
        }
    }
    mutating func removeGroupMember(member: String){
        //remove the item(member) from the groupMember list by getting the index of the element
        //and removing the item at that index
        self.groupMembers.removeAtIndex(self.groupMembers.indexOf(member)!)
    }
}