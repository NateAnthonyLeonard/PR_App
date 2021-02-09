//
//  signup_controller.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 7/6/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth




class signup_controller: UIViewController {
    
    @IBOutlet weak var firstnametextfield: UITextField!
    @IBOutlet weak var lastnametextfield: UITextField!
    @IBOutlet weak var phonetextfield: UITextField!
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passtextfield: UITextField!
   
    @IBOutlet weak var signupbutton: UIButton!
    
    @IBAction func onTap(_ sender: Any) {
         view.endEditing(true)
    }
    
    
    @IBAction func chevronTap(_ sender: Any) {
         let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            firstnametextfield.layer.cornerRadius = 10.0
               //email_login.clipsToBounds = true
            firstnametextfield.layer.masksToBounds = true
            firstnametextfield.layer.borderWidth = 0.5
            firstnametextfield.layer.borderColor = UIColor.lightGray.cgColor
        
            lastnametextfield.layer.cornerRadius = 10.0
               //email_login.clipsToBounds = true
            lastnametextfield.layer.masksToBounds = true
            lastnametextfield.layer.borderWidth = 0.5
            lastnametextfield.layer.borderColor = UIColor.lightGray.cgColor
        
            phonetextfield.layer.cornerRadius = 10.0
               //email_login.clipsToBounds = true
            phonetextfield.layer.masksToBounds = true
            phonetextfield.layer.borderWidth = 0.5
            phonetextfield.layer.borderColor = UIColor.lightGray.cgColor
        
            emailtextfield.layer.cornerRadius = 10.0
               //email_login.clipsToBounds = true
            emailtextfield.layer.masksToBounds = true
            emailtextfield.layer.borderWidth = 0.5
            emailtextfield.layer.borderColor = UIColor.lightGray.cgColor
            
            passtextfield.layer.cornerRadius = 10.0
               //email_login.clipsToBounds = true
            passtextfield.layer.masksToBounds = true
            passtextfield.layer.borderWidth = 0.5
            passtextfield.layer.borderColor = UIColor.lightGray.cgColor
     
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
      
    }
  
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= keyboardSize.height/2
               }
           }
       }

       @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
    
   
    func validateFields() -> String?
    {
        if firstnametextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnametextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailtextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phonetextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passtextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let alert = UIAlertController(title: "Failed Sign Up", message: "Please fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            self.present(alert, animated: true)
        
        }
        // check if password is secure
        let cleanedPassword = passtextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            let passalert = UIAlertController(title: "Failed Sign Up", message: "Please make sure your password is at least 8 characters, contains a special character, and a number.", preferredStyle: .alert)
                passalert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                self.present(passalert, animated: true)
                self.passtextfield.text?.removeAll()
        }
        return nil
    }
    @IBAction func signuptap(_ sender: Any) {
        
        //let error = validateFields()
        
        //if error == nil {
            
            // There's something wrong with the fields, show error message
            //print("Error field input error")
            
        //}
        //else{
        //create clean versions of the data
            let firstName = firstnametextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnametextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailtextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phonenumber = phonetextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passtextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                    
                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "phone_number":phonenumber,  "uid": result!.user.uid ]) { (error) in
                
        
        }
        self.transitionToHome()
    }
   
}
    func transitionToHome() {
        
      let  receiptcontroller = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ReceiptViewController) as? ReceiptViewController
      view.window?.rootViewController = receiptcontroller
      view.window?.makeKeyAndVisible()
        
    }
    
  
}

