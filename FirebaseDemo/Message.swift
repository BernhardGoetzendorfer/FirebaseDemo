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
	let to: String
	let msg: String
	
	init(to: String, msg: String)
	{
		self.to = to
		self.msg = msg
	}
	
	func getTo() -> String
	{
		return to
	}
	
	func getMsg() -> String
	{
		return msg
	}
}
