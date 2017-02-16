//
//  AddViewController.swift
//  FirebaseDemo
//
//  Created by Bernhard Goetzendorfer on 13/02/2017.
//  Copyright © 2017 Bernhard Goetzendorfer. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
	//The List we will load into the Picker
	let recipientList = ["Berni", "Oliver", "Stefan", "Lukas", "Hans", "Peter", "Chris"]
	
	//The reference to the textfield which contains the Message
	@IBOutlet weak var messageField: UITextField!
	
	//The reference to the Picker
	@IBOutlet weak var recipientPicker: UIPickerView!
	
	//Action - will be fired when you click on 'Send'
	@IBAction func sendMessage(_ sender: Any)
	{
		guard let msg = messageField.text else
		{
			return
		}
		
		let recipientRow = recipientPicker.selectedRow(inComponent: 0)
		let recipient = recipientList[recipientRow]
		
		self.msg(to: recipient, withText: msg)
		
		let _ = navigationController?.popViewController(animated: true)
	}
	
	// MARK: - Picker View
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		//The colums for the Picker, we just need 1
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		//Number of Rows in our Picker
		return recipientList.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		//The names of your recipients -- Berni, Oliver, Stefan....
		return recipientList[row]
	}
	
	// MARK: - Helpers
	
	// Send message
	func msg(to user: String, withText msg: String)
	{
		//Build the Connection to the Firebase Database
		let firebaseRef = getDbReference()
		
		//Tell Firebase the structure
		let msgDict = ["recipient": user, "msg": msg]
		
		//Tell Firebase where to save and save the Value
		firebaseRef.child("Messages").childByAutoId().setValue(msgDict)
	}
	
	//Helper for an easy connection to the Database
	private func getDbReference() -> FIRDatabaseReference
	{
		return FIRDatabase.database().reference()
	}
}
