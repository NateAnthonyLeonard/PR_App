//
//  NewPassViewController.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 9/22/20.
//  Copyright © 2020 PR. All rights reserved.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import UIKit

class NewPassViewController: UIViewController {

    @IBOutlet weak var emailPassword: UITextField!
    
    @IBAction func sendpassword(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailPassword.text!)
        {(error) in
            if error != nil {
                return
            }
        }
        let alert = UIAlertController(title: "Password Sent", message: "Please check your email to reset your password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.transitionToHome() }))
        self.present(alert, animated: true)
        //self.transitionToHome()
    }
    
    func transitionToHome() {
        let  logincontroller = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.login_controller) as? login_controller
            view.window?.rootViewController = logincontroller
            view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailPassword.layer.cornerRadius = 10.0
        //email_login.clipsToBounds = true
        emailPassword.layer.masksToBounds = true
        emailPassword.layer.borderWidth = 0.5
        emailPassword.layer.borderColor = UIColor.lightGray.cgColor


        // Do any additional setup after loading the view.
    }
    // Create the user
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
