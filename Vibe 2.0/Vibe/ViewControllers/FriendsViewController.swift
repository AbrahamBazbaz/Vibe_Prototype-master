//
//  FriendsViewController.swift
//  Vibe
//
//  Created by Allan Frederick on 7/26/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

struct cellData
{
	let email: String?
}

class FriendsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBAction func addButton(_ sender: UIBarButtonItem) {
		performSegue(withIdentifier: "goToAddFriend", sender: self)
	}
	
	//Create array that holds Friend data
	var friendsListData: [cellData] = []
	{
		didSet{
			tableView.reloadData()
		}
	}
	
    // Create database reference
    var ref: DatabaseReference?
    
    // Hamburger menu icon
    @IBOutlet weak var menu: UIBarButtonItem!
    
    // Struct for user
    struct homeUser{
        // Variables for user data
        static var nameDisplayed: String = ""
        static var usernameDisplayed: String = ""
        static var vibeStatus: Int = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		getFriends()
		self.tableView.register(FriendCell.self, forCellReuseIdentifier: "custom")
		
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 200
		
		tableView.delegate = (self as! UITableViewDelegate)
		tableView.dataSource = (self as! UITableViewDataSource)
		
        // Do any additional setup after loading the view.
        // Define database reference
        ref = Database.database().reference()
        // Load user info
        loadData()
    }
    
    // Load user data from firebase
    func loadData(){
        // Pull data from firebase once
        self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user values
            let value = snapshot.value as? NSDictionary
            homeUser.nameDisplayed = value?["name"] as? String ?? ""
            homeUser.usernameDisplayed = value?["username"] as? String ?? ""
            homeUser.vibeStatus = value?["vibeStatus"] as? Int ?? 0
            print("Username: " + homeUser.usernameDisplayed)
            print("Vibe Status: ", homeUser.vibeStatus)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // Configure slide out menu functionality
    override func viewWillAppear(_ animated: Bool) {
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        // Detect swipe gesture
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
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

	//Function that gets friends to display
	func getFriends()
	{
		//Get friends list
		let uid = Auth.auth().currentUser?.uid
		Database.database().reference().child("users").child(uid!).child("requests").observeSingleEvent(of: .value, with: { (snapshot) in
			
			//If the friends list is not nil, run through finction
			if let snapDict = snapshot.value as? NSDictionary
			{
				var friendKeys = snapDict.allKeys
			
				let friendSize = friendKeys.count
			
			var friendID: String = ""
			
			var friendEmail: String = ""
			
				//For loop that iterates through friends list and appends data to friend array
				for i in 0...(friendSize - 1)
			{
				friendID = friendKeys[i] as! String
				
				Database.database().reference().child("users").child(friendID).child("email").observeSingleEvent(of: .value, with: { (snapshot) in
					
					let snapString = snapshot.value as! String
					
					friendEmail = snapString
					
					self.friendsListData.append(cellData.init(email: friendEmail))
				}
				)
				}
					print("data from function below")
					print(self.friendsListData)
				}
			
			}
			
		
		)
		print("now returning array")
		
		print(friendsListData)
	}
	
	
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		
//		let uid = Auth.auth().currentUser?.uid
//
//		//Variable that stores number of friends that the user has
//		var numberOfFriends: UInt = 0
//
//
//		//Database reference to snapshot of friend node
//		Database.database().reference().child("users").child(uid!).child("friends").observeSingleEvent(of: .value, with: { (snapshot) in
//			//Number of children is the number of friends
//			numberOfFriends = snapshot.childrenCount
//		}
//		)
		
		//cast the variable from UInt to Int
		//return Int(numberOfFriends)
		
		return friendsListData.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! FriendCell
		
		cell.message = friendsListData[indexPath.row].email
		
		cell.layoutSubviews()
		
		return cell
	}

}
