//
//  Message.swift
//  FirebaseDemo
//
//  Created by Bernhard Goetzendorfer on 13/02/2017.
//  Copyright © 2017 Bernhard Goetzendorfer. All rights reserved.
//

import Foundation

class Message
{
	let recipient: String
	let text: String
	
	init(recipient: String, text: String)
	{
		self.recipient = recipient
		self.text = text
	}
}
