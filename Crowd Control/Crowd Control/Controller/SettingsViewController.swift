//
//  SettingsViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-12-14.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	@IBOutlet weak var logoutButton: UIButton!
	
	@IBAction func onLogoutTapped(sender: AnyObject) {
		let app = UIApplication.sharedApplication().delegate as! AppDelegate
		
		app.modelManager?.logOutCurrentUser()
		
		performSegueWithIdentifier("unwindToGroupList", sender: self)
	}
	
}
