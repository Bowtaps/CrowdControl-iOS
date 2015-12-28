//
//  SettingsViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-12-14.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	@IBOutlet weak var logoutButton: UIBarButtonItem!
	
	@IBAction func onLogoutTapped(sender: AnyObject) {
		
		let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
		
		refreshAlert.addAction(UIAlertAction(title: "Logout", style: .Destructive, handler: { (action: UIAlertAction!) in
			let app = UIApplication.sharedApplication().delegate as! AppDelegate
			app.modelManager?.logOutCurrentUser()
			self.performSegueWithIdentifier("unwindToGroupList", sender: self)
		}))
		
		refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
		
		presentViewController(refreshAlert, animated: true, completion: nil)
	}
	
}
