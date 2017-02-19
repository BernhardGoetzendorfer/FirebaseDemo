//
//  MessageTableViewController.swift
//  FirebaseDemo
//
//  Created by Bernhard Goetzendorfer on 13/02/2017.
//  Copyright © 2017 Bernhard Goetzendorfer. All rights reserved.
//

import UIKit
import Firebase

class MessageTableViewController: UITableViewController
{
	//Variable which holds our Messages
	var messages = [Message]()
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		//Needed to load the Data with observerMessages and put it into our Array: messages and later into the TableViewController
		observeMessages
		{
				(message) in
				
				self.messages.insert(message, at: 0)
				self.tableView.reloadData()
		}
    }

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		// Number of Messages we already sent
		return messages.count
	}

	//Filling the Tableview Cells one by one with the already created Messages.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let msg = messages[indexPath.row]
		
		cell.textLabel?.text = msg.getMsg()
		cell.detailTextLabel?.text = msg.getTo()
		
		return cell
    }
	
	
	//Method to load Messages
	func observeMessages(withHandler handler: @escaping (_ Message: Message) -> ())
	{
		FIRDatabase.database().reference().child("Messages").queryOrderedByKey().observe(.childAdded, with:
			{
				(snapshot) in
				
				let dict = snapshot.value as! NSDictionary
				
				guard let to = dict["recipient"] as? String,
					let msg = dict["msg"] as? String
					else
				{
					print("Error in msg")
					return
				}
				
				let msgObj = Message(to: to, msg: msg)
				
				handler(msgObj)
		})
	}
}
