//
//  ViewController.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 10/24/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit
import Parse
class ViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }

    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        activityIndicator.startAnimating()
        if(!username.isEmpty && !password.isEmpty){
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                }
                self.activityIndicator.stopAnimating()
            }
        }else{
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "Username, Password Required", message: "Please enter your username and password...", preferredStyle: .alert)
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

