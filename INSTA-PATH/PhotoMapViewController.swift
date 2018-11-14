//
//  PhotoMapViewController.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 10/25/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageViewTake: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var btnsend: UIButton!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.activityindicator.stopAnimating()
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func onSubmit(_ sender: Any) {
        self.activityindicator.startAnimating()//now_playing
        btnsend.isEnabled = false
        Post.postUserImage(image: imageViewTake.image, withCaption: captionField.text) { (success: Bool , error: Error?) in
            if success {
                print("success")
                 self.activityindicator.stopAnimating()
                 self.btnsend.isEnabled = true
                
                let alertController = UIAlertController(title: "SUCCESS", message: "Post successful...", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                    // self.fetchAllMovies()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }else{
                print("\(String(describing: error))")
                self.activityindicator.stopAnimating()
                self.btnsend.isEnabled = true
                
                let alertController = UIAlertController(title: "ERROR", message: "\(String(describing: error))", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                    // self.fetchAllMovies()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageViewTake.contentMode = .scaleAspectFill
        // Do something with the images (based on your use case)
        imageViewTake.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
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
