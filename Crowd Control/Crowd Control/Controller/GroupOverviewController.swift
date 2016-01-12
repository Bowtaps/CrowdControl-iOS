//
//  GroupOverviewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-12-28.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

class GroupOverviewController: UIViewController {
	
	var groupToDisplay: GroupModel?
	var groupLeader: UserProfileModel?
	
	@IBOutlet weak var groupNameLabel: UILabel!
	@IBOutlet weak var groupLeaderLabel: UILabel!
	@IBOutlet weak var groupDescriptionLabel: UILabel!
	
	@IBAction func onRequestButtonTapped(sender: AnyObject) {
		if groupToDisplay!.addGroupMember((AppDelegate.instance.modelManager?.currentUser()?.profile)!) {
			groupToDisplay?.saveInBackground {
				(object: BaseModel?, error: NSError?) -> Void in
				
				if error != nil {
					
					// Display an alert if an error occured
					let alert = UIAlertController(title: "Failed to join group", message: "Unable to join the desired group. " + error!.description, preferredStyle: UIAlertControllerStyle.Alert)
					alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
					self.presentViewController(alert, animated: true, completion: nil)
					
				} else {
					
					// Join the group
					AppDelegate.instance.modelManager!.setCurrentGroup(self.groupToDisplay)
					self.performSegueWithIdentifier("segueToGroupScreens", sender: self)
				}
			}
		} else {
			
			// Operation failed because user is already a member of the group
			AppDelegate.instance.modelManager!.setCurrentGroup(self.groupToDisplay)
			self.performSegueWithIdentifier("segueToGroupScreens", sender: self)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let groupToDisplay = groupToDisplay {
			self.groupNameLabel.text = groupToDisplay.groupName
			self.groupDescriptionLabel.text = groupToDisplay.groupDescription
			
			if let groupLeader = groupLeader {
				self.groupLeaderLabel.text = ""
				groupLeader.loadInBackground({ (object, error) -> Void in
					if object != nil && error == nil {
						self.groupLeaderLabel.text = groupLeader.displayName
					} else {
						self.groupLeaderLabel.text = "ERROR LOL"
					}
				})
			} else {
				self.groupLeaderLabel.text = "No leader"
			}
		}
	}
	
}
