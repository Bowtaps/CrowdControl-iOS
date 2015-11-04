//
//  GroupModelTests.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/28/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import XCTest
@testable import Crowd_Control

class GroupTest: XCTestCase{
    
    func testAddGroupMember(){
        let testModel = ParseGroupModel()
        let input = "test"
        testModel.addGroupMember(input)
        XCTAssertEqual(testModel.groupMembers, ["test"])
    }
    func testAddItineraryItem(){
        let testModel = ParseGroupModel()
        let input = "test"
        testModel.addItineraryItem(input)
        XCTAssertEqual(testModel.itinerary!, ["test"])
    }
    func testAddWaypoint(){
        let testModel = ParseGroupModel()
        let input = Waypoint(waypointId: 1, longitude: 1.1, latitude: 2.2, message: "this is a test")
        testModel.addWaypoint(input)
        XCTAssertEqual(testModel.waypoints!.count, 1)
    }
    func testRemoveGroupMember(){
        let testModel = ParseGroupModel()
        let input = "test"
        testModel.addGroupMember(input)
        testModel.removeGroupMember("test")
        XCTAssertEqual(testModel.groupMembers, [])
    }
}

