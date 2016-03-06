//
//  LoginViewController.swift
//  instagram
//
//  Created by Lucas Andrade on 3/1/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        if PFUser.currentUser() != nil{
        }

        PFUser.logInWithUsernameInBackground(userNameField.text!, password: passwordField.text!)
            { (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                print("you are logged in")
                if PFUser.currentUser() != nil{
                }
                
                let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                self.navigationController!.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        if PFUser.currentUser() != nil{
            print("there is a current user3")
        }

        newUser.signUpInBackgroundWithBlock { (success: Bool, error:  NSError?) -> Void in
            if success{
                print("created user")
                if PFUser.currentUser() != nil{
                    print("there is a current user4")
                }

                let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                self.navigationController!.pushViewController(viewController, animated: true)
                

            }
            else{
                if error?.code == 202{
                    print("User name is taken)")
                }
            }
        }
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
