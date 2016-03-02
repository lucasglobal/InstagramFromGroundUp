//
//  CaptionViewController.swift
//  instagram
//
//  Created by Lucas Andrade on 3/1/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController, UITextViewDelegate {

    var pictureTaken: UIImage!
    var descriptionWasEdited: Bool = false
    
    @IBOutlet weak var buttonEndEditing: UIButton!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var pictureTakenImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pictureTakenImageView.image = self.pictureTaken
        self.textViewDescription.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
    
        let sendButton = UIBarButtonItem(title: "Send", style: .Done, target: self, action: "sendButtonNavigationBar")
        self.navigationItem.rightBarButtonItem = sendButton
        
        let button = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "goBack")
        self.navigationItem.leftBarButtonItem = button


        // Do any additional setup after loading the view.
    }
    func sendButtonNavigationBar(){
        print("send to server")
        
        print("size \(pictureTaken.size)")
        let resizedPicture = self.resize(pictureTaken, newSize: CGSize(width: 200, height: 267))
        
        Post.postUserImage(resizedPicture, withCaption: self.textViewDescription.text) { (completed: Bool, error: NSError?) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidBeginEditing(textView: UITextView) {
        //keep text if user has already written something
        if !descriptionWasEdited {
            self.textViewDescription.text = ""
            descriptionWasEdited = true
        }
    }
    
    //move view up if editing
    func keyboardWillShow(sender: NSNotification){
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
            UIView.animateWithDuration(2, animations: { () -> Void in
                self.buttonEndEditing.alpha = 1
            })
        }
    }
    //move view down if editing
    func keyboardWillHide(sender: NSNotification){
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
            UIView.animateWithDuration(2, animations: { () -> Void in
                self.buttonEndEditing.alpha = 0
            })

        }

    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //dismiss keyboard
        self.view.endEditing(true)
    }

    @IBAction func endEditingAction(sender: AnyObject) {
        self.view.endEditing(true)
    }
    func goBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage{
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = .ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}






