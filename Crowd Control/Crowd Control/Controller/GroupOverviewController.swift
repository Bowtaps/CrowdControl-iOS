//
//  GroupOverviewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-12-28.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
/// Group Overview Controller contains the logic for the Group Overiew page.
/// - SeeAlso: 'UIViewController'
class GroupOverviewController: UIViewController {
	/// Group to display in current view
	var groupToDisplay: GroupModel?
    /// User display name of the Group Leader
	var groupLeader: UserProfileModel?
	/// UILabel for group name
	@IBOutlet weak var groupNameLabel: UILabel!
    /// UILabel for group leader name
	@IBOutlet weak var groupLeaderLabel: UILabel!
    /// UILable for group description text
	@IBOutlet weak var groupDescriptionLabel: UILabel!
	/// When user clicks on the group to join
    /// - Parameter sender: Caller of button
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
	/// Overrides superclass then loads data from group object into view.
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
