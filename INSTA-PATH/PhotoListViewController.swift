//
//  PhotoListViewController.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 11/4/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    var refreshControl: UIRefreshControl!
    var imagelist = [PFObject]()
    let currentusr = PFUser.current()!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = 120
        tableview.rowHeight = 120 //UITableViewAutomaticDimension
        
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
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCellTableViewCell
        
        let chat = imagelist[indexPath.row]
        if let user = chat["user"] as? PFUser {
            // User found! update username label with username
            if(currentusr.username == user.username!){
                cell.userLbl.backgroundColor = UIColor.cyan
                cell.userLbl.text = user.username
            }else{
                cell.userLbl.backgroundColor = UIColor.brown
                cell.userLbl.text = user.username
            }
            
        }else{
            cell.userLbl.text = "🤖"
        }
        cell.messageLbl.text = (chat["text"] as! String)
        
        return cell
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
