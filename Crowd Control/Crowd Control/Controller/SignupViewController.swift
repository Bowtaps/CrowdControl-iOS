//
//  SignupViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-13.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
import Parse

/// Custom view controller class for handling user signups.
///
/// Custom UIViewController class for handling user signups. Processes requests, validates input,
/// and passes data to backend for checking with the server, and properly handles both successful
/// and unsuccessful signup requests.
///
/// - Note:
/// This class is a stub, with methods to be implemented as needed
class SignupViewController: UIViewController {
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var passwordConfirmField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	@IBAction func submitButtonTapped(sender: AnyObject) {
		let user = PFUser()
		user.username = emailField.text
		user.email = emailField.text
		user.password = passwordField.text
		
		// other fields can be set just like with PFObject
		user["phone"] = "415-392-0202"
		
		user.signUpInBackgroundWithBlock {
			(succeeded: Bool, error: NSError?) -> Void in
			if let error = error {
				let errorString = error.userInfo["error"] as? NSString
				print (errorString)
			} else {
				// Hooray! Let them use the app now.
				print ("Hooray!")
			}
		}
	}
	
	
}
