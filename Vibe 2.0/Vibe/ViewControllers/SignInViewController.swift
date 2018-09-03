//
//  SignInViewController.swift
//  Vibe
//
//  Created by Allan Frederick on 7/25/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    
    // Define outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    // Sign in user when button is pressed
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        // Call upon AuthService to sign in user
        // Initiate segue after sign-in process is completed
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {self.performSegue(withIdentifier: "signInToPageCtl", sender: nil)}, onError: {error in print(error!)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Initially disable sign in button, until all input is valid
        signInButton.isUserInteractionEnabled = false
        // Round sign-in button
        signInButton.layer.cornerRadius = signInButton.frame.size.width/6
        signInButton.clipsToBounds = true
        // Error checking for text fields
        handleTextField()
    }
    
    // Keep current user signed in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (Auth.auth().currentUser != nil){
            self.performSegue(withIdentifier: "signInToPageCtl", sender: nil)
        }
    }
    
    // Error checking for text fields
    func handleTextField(){
        // Detect if user is editing text fields
        emailTextField.addTarget(self, action: #selector(RegisterTwoViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(RegisterTwoViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    // Detect if all text fields are filled
    @objc func textFieldDidChange() {
        // Check if text fields is not empty. If empty, diable button. If valid, enable button.
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            // Dim register button text if not all text fields are filled
            signInButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            // Keep button disabled
            signInButton.isUserInteractionEnabled = false
            return
        }
        // Lighten register button text if all text fields are filled
        signInButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        // Enable button
        signInButton.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Takes keyboard down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
