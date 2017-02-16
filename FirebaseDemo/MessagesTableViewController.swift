//
//  MessagesTableViewController.swift
//  FirebaseDemo
//
//  Created by Bernhard Goetzendorfer on 13/02/2017.
//  Copyright © 2017 Bernhard Goetzendorfer. All rights reserved.
//

import UIKit
import Firebase

class MessagesTableViewController: UITableViewController {

	var messages = [Message]()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		
		observeMessages
		{
				(message) in
				
				self.messages.insert(message, at: 0)
				self.tableView.reloadData()
		}
		
		
    }

	

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return messages.count
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
		{
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let msg = messages[indexPath.row]
		
		cell.textLabel?.text = msg.getMsg()
		cell.detailTextLabel?.text = msg.getTo()
		
		return cell
    }
	
	
	//Load Messages
	func observeMessages(withHandler handler: @escaping (_ Message: Message) -> ())
	{
		let firebaseRef = FIRDatabase.database().reference()
		
		firebaseRef.child("Messages").queryOrderedByKey().observe(.childAdded, with:
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
