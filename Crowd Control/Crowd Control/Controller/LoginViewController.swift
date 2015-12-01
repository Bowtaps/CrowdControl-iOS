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
class LoginViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	var loginFormFields = [UITextField]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Keep track of field items in form
		loginFormFields = [emailField, passwordField]
		for field in loginFormFields {
			field.delegate = self
		}
	}
	
	/// Callback executed when the submit button has been tapped.
	@IBAction func submitButtonTapped(sender: AnyObject) {
		submitForm()
	}
	
	/// Callback executed when the return button is tapped on the keyboard.
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		
		if textField == loginFormFields.last! {
			submitForm()
		} else {
			
			// Select next form item
			textField.resignFirstResponder()
			for var i = 1; i < loginFormFields.count; i++ {
				if loginFormFields[i-1] == textField {
					loginFormFields[i].becomeFirstResponder()
				}
			}
		}

		return true
	}
	
	/// Hide the keyboard, validate form input, and attempt to log in the user.
	func submitForm() {
		
		// Hide the keyboad
		self.view.endEditing(true)
		
		// Attempt to login in background
		PFUser.logInWithUsernameInBackground(emailField.text!, password:passwordField.text!) {
			(user: PFUser?, error: NSError?) -> Void in
			if user != nil {
				// Do stuff after successful login.
				print ("Login was successful")
				self.performSegueWithIdentifier("rewindToEventView", sender: self)
                } else {
				// The login failed. Check error to see why.
				print ("Failed to login")
			}
		}
	}
}
