//
//  GroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/24/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

class GroupModel{
    var groupLeader: String
    var groupName: String
    //Itinerary is currently set to string to use as a place holder until we know
    //what the data type looks like
    var itinerary: String?
    var status: String?
    var waypoints: [(Double, Double)]?
    var groupMembers: [String]
    
    init(groupLeader: String, groupName: String, itinerary: String,status: String, waypoints: [(Double, Double)], groupMembers: [String]){
        self.groupLeader = groupLeader
        self.groupName = groupName
        self.itinerary = itinerary
        self.status = status
        self.waypoints = waypoints
        self.groupMembers = groupMembers
    }
}

extension GroupModel {
    func addItineraryItem(itineraryItem: String){
        self.itinerary! += itineraryItem
    }
    func addWaypoint(waypoint: (Double, Double)){
        self.waypoints!.append(waypoint)
    }
    func getGroupModel() -> GroupModel {
        return self
    }
    func getGroupName() -> String {
        return self.groupName
    }
    func getItinerary() -> String {
        return self.itinerary!
    }
    func getStatus() -> String {
        return self.status!
    }
    func getWaypoints() -> [(Double, Double)]{
        return self.waypoints!
    }
    func getMemberLocations() -> [(Double, Double)]{
        return [(0.0,0.0)]
    }
    func getGroupMembers() -> [String] {
        return self.groupMembers
    }
    func setGroupName(name: String){
        self.groupName = name
    }
    func setStatus(status: String){
        self.status = status
    }
    func setGroupMembers(members: [String]){
        self.groupMembers = members
    }
}