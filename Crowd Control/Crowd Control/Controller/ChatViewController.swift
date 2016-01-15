//
//  ChatViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-10-27.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

/// Provides a simple model to be used as placeholder content for the UITableView.
class ConversationModel {
	let name: String
	let message: String
	let time: String
	
	/// Main constructor for the class. Initializes values using provided parameters.
	/// - Parameter name: The name of the conversation or person with whom the conversation is with.
	/// - Parameter message: The last message sent in the conversation.
	/// - Parameter time: The last time stamp a message was sent in this conversation.
	init(name: String, message: String, time: String) {
		self.name = name
		self.message = message
		self.time = time
	}
}

/// Controller for the UITableView used to display a list of active conversations on the chat screen.
/// Contains methods that fill the rows in the table with relevant content as well as making calls to
/// the backend to load the current conversations.
class ChatViewController: UITableViewController {
	
	/// Array of ConversationModel objects to display in the table.
	var conversations: [ConversationModel] = [
		ConversationModel(name: "Johnny Appleseed", message: "Hey, where are you guys meeting again?", time: "7:22 PM"),
		ConversationModel(name: "Susan Finch", message: "Where are you?", time: "5:51 PM"),
		ConversationModel(name: "Carl", message: "Lol, that's great. What a moron.", time: "8:36 PM"),
		ConversationModel(name: "John Jacob Jingleheimerschmidt His Name is My Name Too", message: "His name is my name too. Whenever we go out, the people always shout, \"there goes John Jacob Jingleheimerschmidt!\"", time: "12:00 PM")
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var frame = tableView.frame
		frame.size.height = tableView.contentSize.height
		tableView.frame = frame
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return conversations.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("ConversationCell")
		let conversation = conversations[indexPath.row]
		
		let picture = cell?.viewWithTag(100) as! UIImageView
		let nameLabel = cell?.viewWithTag(101) as! UILabel
		let briefLabel = cell?.viewWithTag(102) as! UILabel
		let timeLabel = cell?.viewWithTag(103) as! UILabel
		
		picture.image = UIImage(named: "ugly_mug")
		picture.layer.cornerRadius = picture.frame.width / 2
		picture.clipsToBounds = true
		nameLabel.text = conversation.name
		briefLabel.text = conversation.message
		timeLabel.text = conversation.time
		
		return cell!
	}
	
}
