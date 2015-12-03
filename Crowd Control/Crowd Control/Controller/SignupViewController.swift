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
class SignupViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var passwordConfirmField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	var signupFormFields = [UITextField]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Keep track of field items in form
		signupFormFields = [nameField, emailField, passwordField, passwordConfirmField]
		for field in signupFormFields {
			field.delegate = self
		}
	}
	
	@IBAction func submitButtonTapped(sender: AnyObject) {
		submitForm()
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		
		if textField == signupFormFields.last! {
			submitForm()
		} else {
			
			// Select next form item
			textField.resignFirstResponder()
			for var i = 1; i < signupFormFields.count; i++ {
				if signupFormFields[i-1] == textField {
					signupFormFields[i].becomeFirstResponder()
				}
			}
		}
		
		return true
	}
	
	func submitForm() {
		
		// Hide the keyboard
		self.view.endEditing(true)
		
		// Construct user from field
		let user = PFUser()
		user.username = emailField.text
		user.email = emailField.text
		user.password = passwordField.text
		user["phone"] = "415-392-0202"
		
		// Attempt signup in background
		user.signUpInBackgroundWithBlock {
			(succeeded: Bool, error: NSError?) -> Void in
			if let error = error {
				let errorString = error.userInfo["error"] as? NSString
				print (errorString)
			} else {
				// Hooray! Let them use the app now.
				print ("Hooray!")
				self.performSegueWithIdentifier("rewindToEventView", sender: self)
			}
		}
	}
	
	
}
