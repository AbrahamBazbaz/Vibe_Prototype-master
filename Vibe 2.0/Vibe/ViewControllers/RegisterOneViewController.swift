//
//  RegisterOneViewController.swift
//  Vibe
//
//  Created by Allan Frederick on 8/19/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import UIKit

class RegisterOneViewController: UIViewController {

    // Define outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    
    // Goes to next page when next button is pressed
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "registerNext", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "registerNext"){
            var vc = segue.destination as! RegisterTwoViewController
            vc.name = nameTextField.text
            vc.email = emailTextField.text
            vc.password = passwordTextField.text
        }
    }
    
    // Goes back to Sign-in page
    @IBAction func backTosignIn(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Initially disable next button, until all input is valid
        nextButton.isUserInteractionEnabled = false
        // Round next button
        nextButton.layer.cornerRadius = nextButton.frame.size.width/6
        nextButton.clipsToBounds = true
        // Error checking for text fields
        handleTextField()
    }
    
    // Error checking for text fields
    func handleTextField(){
        // Detect if user is editing text fields
        nameTextField.addTarget(self, action: #selector(RegisterOneViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(RegisterOneViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(RegisterOneViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    // Detect if all text fields are filled
    @objc func textFieldDidChange() {
        // Check if text fields is not empty. If empty, diable button. If valid, enable button.
        guard let name = nameTextField.text, !name.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            // Dim register button text if not all text fields are filled
            nextButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            // Keep button disabled
            nextButton.isUserInteractionEnabled = false
            return
        }
        // Lighten register button text if all text fields are filled
        nextButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        // Enable button
        nextButton.isUserInteractionEnabled = true
    }
    
    // Takes keyboard down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
