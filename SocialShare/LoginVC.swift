//
//  LoginVC.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/13/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func signInBtnPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text, (email.characters.count > 0 && password.characters.count > 0) {
            
            AuthenticationService.instance.login(email: email, password: password, onComplete: { (errorMsg, data) in
                guard errorMsg == nil else {
                    self.displayAlert(title: "Error Authenticating", message: errorMsg!)
                    return
                }
                
            })
            
        } else {
            displayAlert(title: "Email and Password Required", message: "You must enter both an email and a password")
        }
        
    }

    @IBAction func signUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignUpVC", sender: nil)
    }
    
    
}

