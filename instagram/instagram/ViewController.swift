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

class ViewController: UIViewController {
    @IBOutlet weak var imageViewFetched: PFImageView!

    var postsFetched: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.alpha = 1
        self.navigationController?.navigationBar.alpha = 1
        
        
        if let postsFetched = self.postsFetched{
            let media = (postsFetched[0]["media"])!
            print("image data \(media!)")
            self.imageViewFetched.file =  ((media! as? PFFile))
            self.imageViewFetched.loadInBackground()
    
        }
        else{
            self.getPosts()
        }
        //print(posts[0])
    
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
                    //print(posts)
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
}

