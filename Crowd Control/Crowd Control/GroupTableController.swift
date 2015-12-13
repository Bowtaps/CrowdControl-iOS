//
//  GroupListController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-22.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

class GroupTableController: UITableViewController {
	
	var groups: [GroupModel] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let app = UIApplication.sharedApplication().delegate as! AppDelegate
		
		groups = try! app.modelManager!.fetchGroups()
		
		// TODO: fill table with previously loaded values (if not already in table)
		// TODO: asynchronously fetch group listing from server
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
