//
//  DetailsViewController.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 11/23/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit
import Parse

class DetailsViewController: UIViewController {

    var post: Post?
    
    @IBOutlet weak var userpost: UILabel!
    @IBOutlet weak var imagepost: UIImageView!
    @IBOutlet weak var captionpost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userpost.text = post?.author.username
        captionpost.text = post?.caption
        
        if let imageFile : PFFile = post?.media{
            imageFile.getDataInBackground { (data,error) in
                if (error != nil) {
                    print(error.debugDescription)
                }else{
                    self.imagepost?.image = UIImage(data: data!)
                }
            }
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
