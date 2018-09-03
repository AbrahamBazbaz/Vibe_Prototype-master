////
////  RegisterViewController.swift
////  Vibe
////
////  Created by Allan Frederick on 7/26/18.
////  Copyright © 2018 Allan Frederick. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//import FirebaseStorage
//
//class RegisterViewController: UIViewController {
//
//    // Define outlets
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var registerButton: UIButton!
//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var phoneNumberTextField: UITextField!
//
//    // Store optional image
//    var selectedImage: UIImage?
//
//    // Vibe Status
//    var vibeStatus = 0
//
//    // Registers user when button is pressed
//    @IBAction func registerButtonPressed(_ sender: Any) {
//        print("register button pressed")
//        if let profilePhoto = self.selectedImage, let imageData = UIImageJPEGRepresentation(profilePhoto, 0.1){
//            AuthService.signUp(name: nameTextField.text!, username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, phoneNumber: phoneNumberTextField.text!, vibeStatus: vibeStatus, imageData: imageData, onSuccess: {
//                // Initiate segue after register process is complete
//                self.performSegue(withIdentifier: "RegisterToPageCtl", sender: nil)
//            }, onError: {(errorString) in
//                print(errorString!)
//            })
//        } else{
//            print("Profile image can't be empty")
//        }
//    }
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        // Initially disable register button, until all input is valid
//        registerButton.isUserInteractionEnabled = false
//        // Round register button
//        registerButton.layer.cornerRadius = registerButton.frame.size.width/5
//        registerButton.clipsToBounds = true
//        // Round image
//        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
//        profileImage.clipsToBounds = true
//        // User taps profile icon
//        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.selectProfileImageView))
//        profileImage.addGestureRecognizer(TapGesture)
//        profileImage.isUserInteractionEnabled = true
//        // Error checking for text fields
//        handleTextField()
//    }
//
//    // Error checking for text fields
//    func handleTextField(){
//        // Detect if user is editing text fields
//        nameTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
//        usernameTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
//        phoneNumberTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
//        emailTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
//        passwordTextField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
//
//    }
//
//    // Detect if all text fields are filled
//    @objc func textFieldDidChange() {
//        // Check if text fields is not empty. If empty, diable button. If valid, enable button.
//        guard let name = nameTextField.text, !name.isEmpty, let username = usernameTextField.text, !username.isEmpty, let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
//            // Dim register button text if not all text fields are filled
//            registerButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
//            // Keep button disabled
//            registerButton.isUserInteractionEnabled = false
//            return
//        }
//        // Lighten register button text if all text fields are filled
//        registerButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//        // Enable button
//        registerButton.isUserInteractionEnabled = true
//    }
//
//    // Enables selection for profile image
//    @objc func selectProfileImageView() {
//        print("Tapped")
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        present(pickerController, animated: true, completion: nil)
//    }
//
//    // Goes back to Sign-in page
//    @IBAction func backToSignIn(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    // Takes keyboard down
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}
//
//// Lets user select image from camera roll when profile icon is tapped
//extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print("image selected")
//        //profileImage.image = infoPhoto
//        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
//            selectedImage = image
//            profileImage.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}


