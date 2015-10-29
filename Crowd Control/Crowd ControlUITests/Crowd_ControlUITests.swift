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
