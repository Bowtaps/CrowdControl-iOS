//
//  Crowd_ControlUITests.swift
//  Crowd ControlUITests
//
//  Created by Daniel Andrus on 2015-10-15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class Crowd_ControlUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	/// Test for navigating between tabs while in an event
	func testTabSwitching() {
		
		// jump between each button
		let app = XCUIApplication()
		let tabBarsQuery = app.tabBars
		let secondButton = tabBarsQuery.buttons["Second"]
		let chatButton = tabBarsQuery.buttons["Chat"]
		let groupInfoButton = tabBarsQuery.buttons["Group Info"]
		
		// visit each tab once
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		
		// repeated taps
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		
		// back-and-forth taps
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		secondButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Map")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
		chatButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Chat")
	}
	
	/// Test for navigating to map screen and activating the location tracking button
    func testMapTracking() {
		
		// Launch app and go to maps tab
		let app = XCUIApplication()
		app.tabBars.buttons["Second"].tap()
		XCTAssertEqual(app.maps.count, 1)
		
		// Make sure navigation bar is correct
		let navBar = app.navigationBars["Map"]
		XCTAssertEqual(navBar.exists, true)
		
		// Tap the trackingn button
		let trackingButton = app.navigationBars["Map"].buttons["Tracking"]
		trackingButton.tap()
    }
    
}
