//
//  GroupListController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-22.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

class GroupTableController: UITableViewController {
	
	@IBOutlet weak var groupTable: UITableView!
	
	var groups: [GroupModel] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let app = UIApplication.sharedApplication().delegate as! AppDelegate
		
		app.modelManager!.fetchGroupsInBackground {
			(results: [GroupModel]?, error: NSError?) -> Void in
			if results != nil {
				self.groups = results!
				self.groupTable.reloadData()
			}
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let app = UIApplication.sharedApplication().delegate as! AppDelegate
		
		if app.modelManager?.currentUser() == nil {
			performSegueWithIdentifier("segueToWelcomeScreen", sender: self)
		}
	}
	
	/// Function for rewinding to this view, providing a nice target for screens to rewind to.
	/// 
	/// - Parameter segue: The segue object communicated during transfer.
	@IBAction func rewindToGroupList(segue: UIStoryboardSegue) {
		// Does nothing except exist for Interface Builder
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell")
		let group = groups[indexPath.row]
		
		// Create convenience variables for UI elements
		let titleLabel = cell?.viewWithTag(100) as! UILabel
		let subtitleLabel = cell?.viewWithTag(101) as! UILabel
		
		// Fill UI elements with group details
		titleLabel.text = group.groupName
		subtitleLabel.text = group.groupDescription
		
		return cell!
	}
	
}
