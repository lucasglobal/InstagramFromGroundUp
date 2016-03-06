//
//  LoginViewController.swift
//  instagram
//
//  Created by Lucas Andrade on 3/1/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var bluredView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let notificationSettings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        // Do any additional setup after loading the view.
        
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur.frame = self.signInButton.bounds
        blur.userInteractionEnabled = false //This allows touches to forward to the button.
        self.signInButton.insertSubview(blur, atIndex: 0)
        
        let blur2 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur2.frame = self.signUpButton.bounds
        blur2.userInteractionEnabled = false //This allows touches to forward to the button.
        self.signUpButton.insertSubview(blur2, atIndex: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)


        PFUser.logInWithUsernameInBackground(userNameField.text!, password: passwordField.text!)
            { (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                print("you are logged in")
                
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)

                
                let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                self.navigationController!.pushViewController(viewController, animated: true)
            }
            else{
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                //alert of wrong action
                let alert = UIAlertController(title: "Incorrect username or password ", message: "Please, try again", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default) { (action: UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
    }
    @IBAction func onSignUp(sender: AnyObject) {
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        let newUser = PFUser()
        
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        if PFUser.currentUser() != nil{
            print("there is a current user3")
        }

        newUser.signUpInBackgroundWithBlock { (success: Bool, error:  NSError?) -> Void in
            if success{
                print("created user")
                
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)

                let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                self.navigationController!.pushViewController(viewController, animated: true)
                

            }
            else{
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                //alert of wrong action
                let alert = UIAlertController(title: "Username already exists", message: "Please, try a different username", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default) { (action: UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)

                if error?.code == 202{
                    print("User name is taken)")
                }
            }
        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
