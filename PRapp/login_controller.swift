//
//  login_controller.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 7/7/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import UIKit

class login_controller: UIViewController {
    
    @IBOutlet weak var email_login: UITextField!
    
    @IBOutlet weak var pass_login: UITextField!
    
    @IBOutlet weak var signin_button: UIButton!
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
   
              
    override func viewDidLoad() {
        super.viewDidLoad()
       
        email_login.layer.cornerRadius = 10.0
        //email_login.clipsToBounds = true
        email_login.layer.masksToBounds = true
        email_login.layer.borderWidth = 0.5
        email_login.layer.borderColor = UIColor.lightGray.cgColor
        
        pass_login.layer.cornerRadius = 10.0
        //email_login.clipsToBounds = true
        pass_login.layer.masksToBounds = true
        pass_login.layer.borderWidth = 0.5
        pass_login.layer.borderColor = UIColor.lightGray.cgColor
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/1.5
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    //email_login.layer.cornerRadius = 5;
    
    
    @IBAction func signin_tappd(_ sender: Any) {
        
        // Create cleaned versions of the text field
        let email = email_login.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pass_login.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Failed Login", message: "Email or password is incorrect.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.email_login.text?.removeAll()
                self.pass_login.text?.removeAll()
            }
            else {
                self.transitionToHome()
            }
        }

}
    func transitionToHome() {
        //let user = Auth.auth().currentUser
        //view.window?.rootViewController = logincontroller
        //view.window?.makeKeyAndVisible()
        if Auth.auth().currentUser != nil{
             let  receiptcontroller = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ReceiptViewController) as? ReceiptViewController
            view.window?.rootViewController = receiptcontroller
            view.window?.makeKeyAndVisible()
        } else
        {
            print("Not logged in")
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
    
    
}

