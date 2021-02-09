//
//  UserSettingsViewController.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 10/19/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class UserSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

@IBAction func onTapLogout(_ sender: Any) {
    
    //let auth = Auth.auth()
        
    do{
        
        try Auth.auth().signOut()
        
        let  homelogin = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.home_login) as? home_login
        view.window?.rootViewController = homelogin
        view.window?.makeKeyAndVisible()
        
    }catch{ print("already logged out")
        
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
