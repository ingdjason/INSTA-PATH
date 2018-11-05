//
//  RegisterViewController.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 10/25/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit
import Parse
class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.stopAnimating()
    }

    @IBAction func onRegister(_ sender: Any) {
        
        activityIndicator.startAnimating()
        if(!(emailField.text?.isEmpty)! && !(usernameField.text?.isEmpty)! && !(passwordField.text?.isEmpty)! && !(confirmField.text?.isEmpty)!){
            // Set the button state back to default, "Not Selected".
            self.loginButton.isSelected = true
            self.loginButton.isEnabled = false
            
            
            if( confirmField.text! == passwordField.text!){
                // initialize a user object
                let newUser = PFUser()
                // set user properties
                newUser.username = usernameField.text
                newUser.email = emailField.text
                newUser.password = passwordField.text
                // call sign up function on the object
                newUser.signUpInBackground { (success: Bool, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                        self.showalert(title: "Error", message: "\(error.localizedDescription)")
                    } else {
                        print("User Registered successfully")
                        // manually segue to logged in view
                        self.performSegue(withIdentifier: "vcBackRegister", sender: nil)
                    }
                }
                
                self.loginButton.isSelected = false
                self.loginButton.isEnabled = true
            }else{
                activityIndicator.stopAnimating()
                showalert(title: "Different", message: "Password different to confirm password.")
            }
        }else{
            activityIndicator.stopAnimating()
            showalert(title: "Required", message: "Please enter all required information...")
        }
        
    }
    
    func showalert(title: String, message: String ){
        let alertController = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
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
