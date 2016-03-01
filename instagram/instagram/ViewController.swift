//
//  ViewController.swift
//  instagram
//
//  Created by Lucas Andrade on 2/29/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.alpha = 1
        self.navigationController?.navigationBar.alpha = 1

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

