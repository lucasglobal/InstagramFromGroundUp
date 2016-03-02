//
//  Post.swift
//  instagram
//
//  Created by Lucas Andrade on 3/2/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?){
        //create the object that will be sent
        let post = PFObject(className: "Post")
        
        //convert uiimage into nsdata
        let imageData: NSData = UIImagePNGRepresentation(image!)!
        
        post["media"] = PFFile(data: imageData)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        
        post.saveInBackgroundWithBlock(completion)
    }
}
