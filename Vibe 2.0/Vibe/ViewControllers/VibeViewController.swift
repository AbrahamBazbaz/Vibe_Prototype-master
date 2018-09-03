//
//  VibeViewController.swift
//  Vibe
//
//  Created by Allan Frederick on 7/26/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class VibeViewController: UIViewController {
    
    // Define outlets
    @IBOutlet weak var vibeSwitch: UISwitch!
    
    // UID of current user
    var uid : String = ""
    
    // Set handler type to authentication change listener
    var handle: AuthStateDidChangeListenerHandle?
    
    // Create handler to wait for authentication state change to get uid
    func stateChangeHandler(){
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.uid = (Auth.auth().currentUser?.uid)!
        }
    }
    
    // Create database reference
    var ref: DatabaseReference?
    
    // Toggle Vibe switch
    @IBAction func vibeSwitchToggle(_ sender: Any) {
            // Turn on vibe
            if self.vibeSwitch.isOn == true{
                self.ref?.child("users").child(uid).child("vibeStatus").setValue(1)
                print("vibe on")
            }
            // Turn off vibe
            else{
                self.ref?.child("users").child(uid).child("vibeStatus").setValue(0)
                print("off")
            }
            // Read user information
            self.readUserInfo()
        
    }
    
    // Read user information to database
    func readUserInfo(){
            // Pull data from firebase once
            self.ref?.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user values
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let vibeStatus = value?["vibeStatus"] as? Int ?? 0
            print("Username: " + username)
            print("Vibe Status: ", vibeStatus)
            // ...
            }) { (error) in
            print(error.localizedDescription)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // define database reference
        ref = Database.database().reference()
        // Call handler
        stateChangeHandler()
        //self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
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
