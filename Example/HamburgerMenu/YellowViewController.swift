//
//  ViewController.swift
//  HamburgerMenu
//
//  Created by Tanner Nelson on 01/14/2016.
//  Copyright (c) 2016 Tanner Nelson. All rights reserved.
//

import UIKit
import HamburgerMenu

class YellowViewController: UIViewController {

    @IBAction func exampleOneAction(sender: UIButton) {
        
        if let menuController = self.tabBarController as? HamburgerMenu.MenuController {
            menuController.menu.toggle(true)
        }
        
    }
}

