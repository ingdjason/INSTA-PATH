//
//  PhotoListViewController.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 11/4/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit
import Parse

class PhotoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    var refreshControl: UIRefreshControl!
    var imagelist = [Post]()
   // let currentusr = PFUser.current()!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = 350
        tableview.rowHeight = 350 //UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoListViewController.didPullToRefresh(_:)), for: .valueChanged)
        loadData()
        tableview.insertSubview(refreshControl, at: 0)
        self.tableview.reloadData()
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("TOTAL MSG : \(msg.count)")
        return imagelist.count
    }
    
    @IBAction func logoutFunc(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                self.showalert(title: "Required", message: "Successful loggout...")
                // Load and show the login view controller
                //let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginoutVC")
                //self.window?.rootViewController = loginViewController
            }
        })
    }
    
    func showalert(title: String, message: String ){
        let alertController = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
            exit(1)
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PhotoCellTableViewCell
        let imagelists = imagelist[indexPath.row]
        
        cell.labelpost.text = imagelists.caption
        cell.username.text = imagelists.author.username
        cell.labelpost.layer.cornerRadius = 17
        cell.imageview.layer.cornerRadius = 17
        
        if let imageFile : PFFile = imagelists.media{
            imageFile.getDataInBackground { (data,error) in
                if (error != nil) {
                    print(error.debugDescription)
                }else{
                    cell.imageview?.image = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "vcDetails") {
            let cell = sender as! UITableViewCell
            let indexPath = tableview.indexPath(for: cell)
            let imagedata = imagelist[indexPath!.row]
            // Get the new view controller using segue.destinationViewController.
            let detailsViewController = segue.destination as! DetailsViewController
            // Pass the selected object to the new view controller.
            detailsViewController.post = imagedata
        }else{
            //print("segue not ok")
        }
    }

    func loadData(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        query?.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                self.imagelist = objects! as! [Post]
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
                
            }
            else {
                print(error!.localizedDescription)
            }
        }
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
