//
//  ViewController.swift
//  eHealthAuthentication
//
//  Created by Ioana Bojinca on 29.05.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var newUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressSignUp(_ sender: Any) {
        validateTextFieldData()
        self.performSegue(withIdentifier: "goToVerificationCodeVC", sender: self)
    }
    
    func validateTextFieldData() {
        if let phoneNumber = phoneNumberTextField.text {
        self.newUser = User(phoneNumber: phoneNumber)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let viewController = segue.destination as? VerificationCodeViewController {
                if self.newUser != nil {
                    viewController.user = newUser
                }
            }
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return false
    }
}

