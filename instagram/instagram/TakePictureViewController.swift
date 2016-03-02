//
//  TakePictureViewController.swift
//  instagram
//
//  Created by Lucas Andrade on 3/1/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class TakePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.alpha = 0
        self.navigationController?.navigationBar.alpha = 0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.alpha = 0
        self.navigationController?.navigationBar.alpha = 0

        
        let vc = UIImagePickerController()
        vc.delegate = self
        //vc.allowsEditing = true
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)){
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else{
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(vc, animated: true, completion: nil)
        //change tabbar controlle just when viewController was displayed
        delay(1) {
            self.tabBarController?.selectedIndex = 0
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage

        let captionVC = storyboard?.instantiateViewControllerWithIdentifier("captionVC") as! CaptionViewController
        captionVC.pictureTaken = originalImage
        
        self.navigationController?.pushViewController(captionVC, animated: true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
