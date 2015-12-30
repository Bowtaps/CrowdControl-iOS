//
//  LoginViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-13.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import UIKit

/// Custom view controller class for handling user logins.
///
/// Custom UIViewController class for handling user logins. Processes requests, validates input,
/// and passes data to backend for checking with the server, and properly handles both successful
/// and unsuccessful login requests.
/// 
/// - Note:
/// This class is a stub, with methods to be implemented as needed
class LoginViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	var loginFormFields = [UITextField]()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		registerForKeyboardNotifications()
	}
	
	deinit {
		deregisterFromKeyboardNotifications()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Keep track of field items in form
		loginFormFields = [emailField, passwordField]
		for field in loginFormFields {
			field.delegate = self
		}
	}
	
	func registerForKeyboardNotifications() {
		//Adding notifies on keyboard appearing
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
	func deregisterFromKeyboardNotifications() {
		//Removing notifies on keyboard appearing
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
	func adjustForKeyboard(notification: NSNotification) {
		let userInfo = notification.userInfo!
		
		let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
		let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
		
		var inset = scrollView.contentInset
		
		if notification.name == UIKeyboardWillHideNotification {
			inset.bottom = 0
		} else {
			inset.bottom = keyboardViewEndFrame.height
		}
		
		scrollView.contentInset = inset
		
		scrollView.scrollIndicatorInsets = scrollView.contentInset
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
		let app = UIApplication.sharedApplication().delegate as! AppDelegate
		
		app.modelManager!.logInUserInBackground(emailField.text!, password: passwordField.text!) {
			(user: UserModel?, error: NSError?) in
			if user != nil {
				print("Login was successful")
				self.performSegueWithIdentifier("unwindToWelcomeView", sender: self)
			} else {
				print("Failed to login")
				let alert = UIAlertController(title: "Login failed", message: "An error occured during login. Please make sure the email and password are correct.", preferredStyle: UIAlertControllerStyle.Alert)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
				self.presentViewController(alert, animated: true, completion: nil)
			}
		}
	}
}
