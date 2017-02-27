//
//  SignUpVC.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/14/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailField: RoundTextField!
    @IBOutlet weak var passwordField: RoundTextField!
    @IBOutlet weak var usernameField: RoundTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        usernameField.delegate = self
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        var valid = true
        let emailRegex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegex, options: [])
            let results = regex.matches(in: email, options: [], range: NSRange(location: 0, length: email.characters.count))
        
            if results.count == 0 {
                valid = false
            }
            
        } catch {
            print("MOR: Error parsing email data")
        }
        
        return valid
    }
    
    @IBAction func policyBtnPressed(_ sender: Any) {
        displayAlert(title: "Terms of Use and Privacy Policy Alert", message: "This is a demo app.  Terms and policies do not exist.  Nonetheless, thank you for checking out the terms of use and the privacy policy.")
    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text, let username = usernameField.text, (email.characters.count > 0 && password.characters.count > 0 && username.characters.count > 0) {
            
            if password.characters.count < 6 {
                displayAlert(title: "Password too short", message: "Password must be at least 6 characters.")
                return
            }
            
            if username.characters.count < 4 {
                displayAlert(title: "Username too short", message: "Username must be at least 4 characters.")
                return
            }
            
            if username.characters.count > 24 {
                displayAlert(title: "Username too long", message: "Username must be less than 25 characters")
            }
            
            if !isValidEmail(email) {
                displayAlert(title: "Invalid Email Address", message: "Please enter a valid email address.")
                return
            }
            
            DatabaseService.instance.isDuplicateUsername(for: username) { (errorMsg, data) in
                if errorMsg != nil {
                    self.displayAlert(title: "Username not available", message: errorMsg!)
                    return
                } else {
                    
                    // By this point, all three fields have been validated
                    AuthenticationService.instance.createUser(email: email, password: password) { (errorMsg, data) in
                        
                        let data: [String: AnyObject] = ["email": email as AnyObject, "username": username as AnyObject]
                        
                        if errorMsg != nil {
                            self.displayAlert(title: "Error Creating User", message: errorMsg!)
                        } else {
                            DatabaseService.instance.saveUser(with: data)
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        } else {
            displayAlert(title: "All fields are required", message: "You must enter an email, a password, and a username")
        }

    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
