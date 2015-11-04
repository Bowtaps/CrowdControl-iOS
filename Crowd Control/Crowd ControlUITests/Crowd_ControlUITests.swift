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
	
	/// Sets up each test by executing these pre-test actions. Launches the app and configures test
	/// settings.
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
	
	/// Cleans up after each test. Closes the app and performs any post-test cleanup and releasing
	/// of dynamically allocated memory.
    override func tearDown() {
        super.tearDown()
    }
	
	/// Tests the various buttons and UI elements on the welcome screen.
	func testWelcomeScreen() {
		
		let app = XCUIApplication()
		let loginWithEmailButton = app.buttons["Login with Email"]
		loginWithEmailButton.tap()
		XCTAssertEqual(app.textFields["Login Email Field"].exists, true)
		XCTAssertEqual(app.secureTextFields["Login Password Field"].exists, true)
		
		let cancelButton = app.navigationBars["Login"].buttons["Cancel"]
		cancelButton.tap()
		XCTAssertEqual(app.textFields["Login Email Field"].exists, false)
		XCTAssertEqual(app.secureTextFields["Login Password Field"].exists, false)
		
		loginWithEmailButton.tap()
		XCTAssertEqual(app.textFields["Login Email Field"].exists, true)
		XCTAssertEqual(app.secureTextFields["Login Password Field"].exists, true)
		
		cancelButton.tap()
		XCTAssertEqual(app.textFields["Login Email Field"].exists, false)
		XCTAssertEqual(app.secureTextFields["Login Password Field"].exists, false)
	}
	
	/// Tests logging in using email and password from the welcome screen.
	func testLoginEmail() {
		
		let app = XCUIApplication()
		app.buttons["Login with Email"].tap()
		
		let johnnyAppleseedIcloudComTextField = app.textFields["Login Email Field"]
		johnnyAppleseedIcloudComTextField.tap()
		johnnyAppleseedIcloudComTextField.typeText("test@bowtaps.com")
		
		let secureTextField = app.secureTextFields["Login Password Field"]
		secureTextField.tap()
		secureTextField.tap()
		secureTextField.typeText("password")
		app.buttons["Login"].tap()
		
		XCTAssertEqual(app.tabBars.count, 1)
		XCTAssertEqual(app.navigationBars["Group Info"].exists, true)
	}
	
	/// Test for navigating to map screen and activating the location tracking button.
    func testMapTracking() {
		
		testLoginEmail()
		
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
    
	/// Test for navigating between tabs while in an event. Simply taps each of the different tabs
	/// using different patterns. The tests pass as long as the navigation bar's identifier (title)
	/// matches the expected page.
	func testTabSwitching() {
		
		testLoginEmail()
		
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
		groupInfoButton.tap()
		XCTAssertEqual(app.navigationBars.elementAtIndex(0).identifier, "Group Info")
	}
	
}
