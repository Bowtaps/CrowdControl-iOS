//
//  GroupListController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-11-22.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

class GroupTableController: UITableViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// TODO: fill table with previously loaded values (if not already in table)
		// TODO: asynchronously fetch group listing from server
	}
	
	/// Function for rewinding to this view, providing a nice target for screens to rewind to.
	/// 
	/// - Parameter segue: The segue object communicated during transfer.
	@IBAction func rewindToGroupList(segue: UIStoryboardSegue) {
		// Does nothing except exist for Interface Builder
	}
	
}
