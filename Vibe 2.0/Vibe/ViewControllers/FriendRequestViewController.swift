//
//  FriendRequestViewController.swift
//  Vibe
//
//  Created by Abey Bazbaz on 9/2/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FriendRequestViewController: UIViewController {

	@IBOutlet weak var newFriendTextField: UITextField!
	
	
	@IBAction func newFriendRequest(_ sender: Any) {
		friendRequest()
	}
	
	func friendRequest()
	{
		//If the textbox is filled out, continue
		if let friendEmail = newFriendTextField.text {
			
			//Create the user variable and save the current user's id
			let user = Auth.auth().currentUser
			
			let uid = user?.uid
			
			//Search through the database to find any user that matches the email input
			Database.database().reference().child("users").queryOrdered(byChild: "email").queryEqual(toValue: friendEmail).observeSingleEvent(of: .value, with: { (snapshot) in
				
				//If the user exists, add to friends list
				if (snapshot.exists()) {
					
					//Variables that hold the friend's user id
					var key : String?
					var keyTwo : String?
					
					//For loop that goes through the children of the user snapshot
					for child in snapshot.children
					{
						let snap = child as! DataSnapshot
						key = snap.key
					}
					
					//Required in order to work
					keyTwo = key!
					
					//Cast friend id as a string and make a dictionary for boolean true
					//let currentUserRequestsList = [keyTwo! as String: true]
					
					//Create new child of friends for current user and set new friend user id: true
					//					Database.database().reference().child("users").child(uid!).child("requests").updateChildValues(currentUserRequestsList) { (err, ref) in
					//						if err != nil{
					//							print(err!)
					//							return
					//						}
					//
					//					}
					
					//Cast current user id as a string and make a dictionary for boolean true
					
					//CHANGE TO REQUESTS AFTER TESTING
					let newFriendRequestsList = [uid! as String: true]
					
					//Create new child of friends for friend user and set the current user id: true
					Database.database().reference().child("users").child(keyTwo!).child("requests").setValue(newFriendRequestsList) { (err, ref) in
						if err != nil{
							print(err!)
							return
						}
						
					}
					
					
				}
					
					//User does not exist
				else
				{
					print("No such user exists")
				}
				
				
			}, withCancel: { (error) in
				//Print out error
				print(error)
			})
			
		}
		
		//Go home
		performSegue(withIdentifier: "goToFriends", sender: self)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
