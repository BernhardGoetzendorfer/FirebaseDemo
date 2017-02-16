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
	let recipientList = ["Berni", "Oliver", "Stefan", "Lukas", "Hans", "Peter", "Chris"]
	
	
	@IBOutlet weak var messageField: UITextField!
	
	@IBOutlet weak var recipientPicker: UIPickerView!
	
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
	
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	private func getDbReference() -> FIRDatabaseReference
	{
		return FIRDatabase.database().reference()
	}
	
	
	// MARK: - Textfield Delegate
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		messageField.resignFirstResponder()
		return true
	}
	
	// MARK: - Picker View
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return recipientList.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return recipientList[row]
	}
	
	// MARK: - Helpers
	
	// Send message
	func msg(to user: String, withText msg: String)
	{
		let firebaseRef = getDbReference()
		
		let msgDict = ["recipient": user, "msg": msg]
		
		firebaseRef.child("Messages").childByAutoId().setValue(msgDict)
	}
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
