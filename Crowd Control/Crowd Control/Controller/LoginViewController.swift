//
//  LoginViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-13.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
import Parse

/// Custom view controller class for handling user logins.
///
/// Custom UIViewController class for handling user logins. Processes requests, validates input,
/// and passes data to backend for checking with the server, and properly handles both successful
/// and unsuccessful login requests.
/// 
/// - Note:
/// This class is a stub, with methods to be implemented as needed
class LoginViewController: UIViewController {
	
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	@IBAction func submitButtonTapped(sender: AnyObject) {
		PFUser.logInWithUsernameInBackground(emailField.text!, password:passwordField.text!) {
			(user: PFUser?, error: NSError?) -> Void in
			if user != nil {
				// Do stuff after successful login.
				print ("Login was successful")
                let newuser = ParseUserModel()
                newuser.load()
			} else {
				// The login failed. Check error to see why.
				print ("Failed to login")
			}
		}
	}
	
}
