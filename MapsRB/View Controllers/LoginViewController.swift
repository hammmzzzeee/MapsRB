//
//  LoginViewController.swift
//  MapsRB
//
//  Created by HAMZA on 10/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController , GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        GIDSignIn.sharedInstance().uiDelegate = self
        
        // automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        //self.performSegue(withIdentifier: "moveToMap", sender: self)

       
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
