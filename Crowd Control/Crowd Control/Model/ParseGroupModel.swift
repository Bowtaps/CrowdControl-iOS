//
//  ParseGroupModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/31/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

class ParseGroupModel: GroupModel {
    var groupLeader: String
    var groupName: String
    //Itinerary is currently set to string to use as a place holder until we know
    //what the data type looks like
    var itinerary: [String]?
    var status: String?
    var waypoints: [Waypoint]?
    var groupMembers: [String]
    
    init(){
        self.groupLeader = ""
        self.groupName = ""
        self.itinerary = nil
        self.status = nil
        self.waypoints = nil
        self.groupMembers = []
    }
    func addGroupMember(member: String){
        self.groupMembers += [member]
    }
    func addItineraryItem(itineraryItem: String){
        if self.itinerary == nil {
            self.itinerary = [itineraryItem]
        }
        else {
            self.itinerary! += [itineraryItem]
        }
    }
    func addWaypoint(waypoint: Waypoint){
        if self.waypoints == nil {
            self.waypoints = [waypoint]
        }else{
            self.waypoints! += [waypoint]
        }
    }
    func removeGroupMember(member: String){
        //remove the item(member) from the groupMember list by getting the index of the element
        //and removing the item at that index
        self.groupMembers.removeAtIndex(self.groupMembers.indexOf(member)!)
    }
    func load(){
        //TODO Write the code for parse loading communication
    }
    func loadAsync(){
        //TODO Write the code for parse loading asynchronously
    }
    func save(){
        //TODO Write the code for sending the data to parse
    }
    func saveAsync(){
        //TODO Write the code for sending the data to parse asynchronously
    }

}
