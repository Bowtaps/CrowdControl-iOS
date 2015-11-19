//
//  WelcomeViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-2.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class WelcomeViewController: UIViewController {
	
	var goToEventView = false
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if goToEventView {
			performSegueWithIdentifier("segueToMainView", sender: self)
		}
	}
	
	@IBAction func facebookButtonTapped(sender: AnyObject) {
		print ("tapped")
		PFFacebookUtils.logInInBackgroundWithReadPermissions([]) {
			(user: PFUser?, error: NSError?) -> Void in
			if let user = user {
				if user.isNew {
					print("User signed up and logged in through Facebook!")
				} else {
					print("User logged in through Facebook!")
				}
			} else {
				print("Uh oh. The user cancelled the Facebook login.")
			}
		}
	}
	
	@IBAction func rewindToWelcomeView(segue: UIStoryboardSegue) {
		// Does nothing except exist for Interface Builder
	}
	
	@IBAction func rewindToEventView(segue: UIStoryboardSegue) {
		// Accepts a rewind segue and displays event view
		goToEventView = true
	}
	
}
