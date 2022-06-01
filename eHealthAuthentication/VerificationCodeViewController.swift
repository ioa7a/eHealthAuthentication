//
//  VerificationCodeViewController.swift
//  eHealthAuthentication
//
//  Created by Ioana Bojinca on 01.06.2022.
//

import UIKit
import FirebaseAuth

class VerificationCodeViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorLabel.isHidden = true
        
        Auth.auth().languageCode = "ro";
        
        if let user = user, let phoneNumber = user.phoneNumber {
            PhoneAuthProvider.provider()
                .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                        self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                }
        }
    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    @IBAction func didTouchValidate(_ sender: Any) {
        self.errorLabel.isHidden = true
        if let verificationCode = verificationCodeTextField.text,
           verificationCode.count >= 6,
           let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") {
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID,
                verificationCode: verificationCode)
            self.signIn(withCredential: credential)
        } else {
            self.errorLabel.isHidden = false
            self.errorLabel.text = "Please insert a valid verification code."
        }
    }
    
    func signIn(withCredential credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
            } else {
                if let phoneNumber = self.user?.phoneNumber, phoneNumber.last == "7" {
                    self.performSegue(withIdentifier: "goToAdminPage", sender: self)
                } else {
                    self.performSegue(withIdentifier: "goToNormalPage", sender: self)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return false
    }
    
}
