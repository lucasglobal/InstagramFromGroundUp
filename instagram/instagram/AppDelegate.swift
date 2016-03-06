//
//  AppDelegate.swift
//  instagram
//
//  Created by Lucas Andrade on 2/29/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        //connects with server
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "instagramFromGroundUp"
                configuration.clientKey = "naneninonu"
                configuration.server = "https://radiant-fortress-19628.herokuapp.com/parse"
            })
        )
        
        //verify if exists current user in cache memory
        if PFUser.currentUser() != nil{
            let rootViewController = self.window!.rootViewController as! UINavigationController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
            viewController.tabBar.tintColor = UIColor(red: 126/255.0, green: 68/255.0, blue: 225/255.0, alpha: 1)
            viewController.tabBar.backgroundColor = UIColor(red: 1, green: 1, blue:1, alpha: 0.5)
            viewController.tabBar.translucent = true
            

            
            UITabBar.appearance().barTintColor = UIColor.clearColor()
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().shadowImage = UIImage()

            let blur = UIVisualEffectView(effect: UIBlurEffect(style:
                UIBlurEffectStyle.Light))
            blur.frame = viewController.tabBar.bounds
            blur.userInteractionEnabled = false //This allows touches to forward to the button.
            viewController.tabBar.insertSubview(blur, atIndex: 0)

            rootViewController.pushViewController(viewController, animated: true)
        }

        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

