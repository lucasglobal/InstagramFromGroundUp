//
//  ViewController.swift
//  instagram
//
//  Created by Lucas Andrade on 2/29/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var postsFetched: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.alpha = 1
        self.navigationController?.navigationBar.alpha = 1
        
        if self.postsFetched == nil{
            self.getPosts()
        }
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logOut(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func getPosts(){
        let query = PFQuery(className: "Post")
        query.orderByAscending("createdAt")
        
        query.includeKey("author")
        query.limit = 20
        
        //fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts{
                if !posts.isEmpty{
                    self.postsFetched = posts
                    self.viewDidAppear(true)
                }
                else{
                    print("there is no posts")
                }
            }
            else{
                print("posts error")
            }
        }

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let postsFetched = self.postsFetched{
            print(postsFetched.count)
            return postsFetched.count
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostsTableViewCell
        
        
        if((self.postsFetched) != nil){
            let arrayData = postsFetched![indexPath.section]
            let author = arrayData["author"] as! PFUser
            cell.imageViewFetched.file =  (arrayData["media"] as! PFFile)
            cell.imageViewFetched.loadInBackground()
            cell.buttonWithName.titleLabel?.sizeToFit()
            cell.buttonWithName.setTitle(author.username, forState: .Normal)
            cell.textViewDescription.text = arrayData["caption"] as! String
        }
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let arrayData = postsFetched![section]
        let author = arrayData["author"] as! PFUser

        let returnedView = UIView()
        returnedView.frame = CGRectMake(0, 0, 100, 60)
        returnedView.backgroundColor = UIColor.whiteColor()
            
        
        let buttonProfilePicture = UIButton(type: UIButtonType.System)
        //centralizing button taking into consideration header view and size of button(10)
        buttonProfilePicture.frame = CGRectMake(0,returnedView.frame.size.height/2 - 15, 20, 20)
        buttonProfilePicture.backgroundColor = UIColor.whiteColor()
        buttonProfilePicture.setImage(UIImage(named: "personal-icon"), forState: .Normal)
        buttonProfilePicture.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center

        let buttonName = UIButton(type: UIButtonType.System)
        //centralizing button taking into consideration header view and size of button(10)
        buttonName.frame = CGRectMake(buttonProfilePicture.frame.origin.x + 20, returnedView.frame.size.height/4 + 5, 500, 10)
        buttonName.backgroundColor = UIColor.whiteColor()
        buttonName.setTitle(author.username!, forState: UIControlState.Normal)
        buttonName.setTitleColor( UIColor.init(red: 49/255.0, green: 139/255.0, blue: 196/255.0, alpha: 1), forState: .Normal)
        buttonName.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 15)
        buttonName.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        //button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)

        returnedView.addSubview(buttonProfilePicture)
        returnedView.addSubview(buttonName)
        
        
        return returnedView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

}

