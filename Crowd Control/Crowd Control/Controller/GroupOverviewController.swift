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
		print("Helloo! :D")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let groupToDisplay = groupToDisplay {
			self.groupNameLabel.text = groupToDisplay.groupName
			self.groupDescriptionLabel.text = groupToDisplay.groupDescription
			
			if let groupLeader = groupLeader {
				self.groupLeaderLabel.text = groupLeader.displayName
			}
		}
	}
	
}
