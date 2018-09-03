//
//  MenuViewController.swift
//  Vibe
//
//  Created by Allan Frederick on 8/15/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var vibeSwitch: UISwitch!
    
    
    @IBAction func vibeSwitchToggle(_ sender: Any) {
        // Turn on vibe
        if self.vibeSwitch.isOn == true{
            self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("vibeStatus").setValue(1)
            print("vibe on")
        }
            // Turn off vibe
        else{
            self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("vibeStatus").setValue(0)
            print("off")
        }
    }
    
    
    // Create database reference
    var ref: DatabaseReference?
    
    // Store array of menu items
    var menuItems:Array = [String]()
    
    // Index counter
    var indxCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Define database reference
        ref = Database.database().reference()
        // Generate an array of menu items
        menuItems = ["Home", "Profile", "Settings", "Logout"]
        // Load user data from firebase
        name.text = FriendsViewController.homeUser.nameDisplayed
        username.text = FriendsViewController.homeUser.usernameDisplayed
    }
    
    // Set the number of rows, based on the number of menu items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // Populate table cell rows with corresponding menu item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.menuItemLabel.text = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Detect selected row
        indxCount = indexPath.row
        // Logout detection
        if (indxCount == 3){
            userLogout()
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)
        }
        else{
            // Go to corresponding view controller
            self.performSegue(withIdentifier: menuItems[indexPath.row], sender: self)
        }
    }
    
    // Logout the user
    func userLogout(){
        print(Auth.auth().currentUser)
        do{
            try Auth.auth().signOut()
        }
        catch let logoutError{
            print(logoutError)
        }
        print(Auth.auth().currentUser)
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
