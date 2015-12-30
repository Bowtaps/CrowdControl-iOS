//
//  SignupViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-13.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

/// Custom view controller class for handling user signups.
///
/// Custom UIViewController class for handling user signups. Processes requests, validates input,
/// and passes data to backend for checking with the server, and properly handles both successful
/// and unsuccessful signup requests.
///
/// - Note:
/// This class is a stub, with methods to be implemented as needed
class SignupViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var scrollView: UIScrollView!
	
	@IBOutlet weak var facebookButton: UIButton!
	@IBOutlet weak var twitterButton: UIButton!
	@IBOutlet weak var emailButton: UIButton!
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var passwordConfirmField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	
	var signupFormFields = [UITextField]()
	
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
		signupFormFields = [nameField, emailField, passwordField, passwordConfirmField]
		for field in signupFormFields {
			field.delegate = self
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		unwindIfLoggedIn()
	}
	
	@IBAction func facebookButtonTapped(sender: AnyObject) {
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
	
	@IBAction func twitterButtonTapped(sender: AnyObject) {
		let alert = UIAlertController(title: "Not Implemented", message: "Twitter login is not ready yet. :)", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	@IBAction func submitButtonTapped(sender: AnyObject) {
		submitForm()
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
				let alert = UIAlertController(title: "Signup failed", message: "An error occured during signup.", preferredStyle: UIAlertControllerStyle.Alert)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
				self.presentViewController(alert, animated: true, completion: nil)
			} else {
				// Hooray! Let them use the app now.
				print ("Hooray!")
				self.unwindIfLoggedIn()
			}
		}
	}
	
	func unwindIfLoggedIn() {
		let app = UIApplication.sharedApplication().delegate as! AppDelegate
		if app.modelManager?.currentUser() != nil {
			performSegueWithIdentifier("unwindToGroupList", sender: self)
		}
	}
	
	@IBAction func rewindToWelcomeView(segue: UIStoryboardSegue) {
		// Does nothing except exist for Interface Builder
	}
	
}
