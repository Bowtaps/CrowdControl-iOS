//
//  GroupInfoViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-10-15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

/// Controller for manipulating the group info view, which displays basic group information and
/// lists of members and group leaders.
class GroupInfoViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func onLeaveGroupButtonTapped(sender: AnyObject) {
		let leaveAlert = UIAlertController(title: "Leave Group", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
		
		leaveAlert.addAction(UIAlertAction(title: "Leave", style: .Default, handler: {
			(action: UIAlertAction!) in
			let user = AppDelegate.instance.modelManager!.currentUser()!
			let group = AppDelegate.instance.modelManager!.currentGroup()!
			
			if group.removeGroupMember(user.profile) {
				group.saveInBackground {
					(object: BaseModel?, error: NSError?) -> Void in
					
					if error != nil {
						
						// Display an alert if an error occured
						let alert = UIAlertController(title: "Failed to leave group", message: "Unable to leave the group. You're stuck here forever!! " + error!.description, preferredStyle: UIAlertControllerStyle.Alert)
						alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
						self.presentViewController(alert, animated: true, completion: nil)
						
					} else {
						
						// Join the group
						AppDelegate.instance.modelManager!.setCurrentGroup(nil)
						self.performSegueWithIdentifier("rewindToGroupList", sender: self)
						
					}
				}
			}
		}))
		
		leaveAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
		
		presentViewController(leaveAlert, animated: true, completion: nil)
	}

}

