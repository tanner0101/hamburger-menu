//
//  HamburgerMenuController.swift
//  Alexander Black
//
//  Created by Tanner Nelson on 1/14/16.
//  Copyright © 2016 Blue Bite. All rights reserved.
//

import UIKit

@IBDesignable
class HamburgerMenuController: UITabBarController {

    //MARK: Interface
    var menu: HamburgerMenu!
    
    //MARK: Properties
    @IBInspectable var menuNib: String!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = HamburgerMenuControllerView(frame: self.view.frame)
        view.backgroundColor = UIColor.redColor()
        
        view.addSubview(self.view)
        self.view.constrainToSuperview(view)
        
        self.view = view

        //hide the default tab bar
        self.tabBar.hidden = true
        
        //add the menu
        self.menu = HamburgerMenu.addTo(self.view, menuNib: self.menuNib, delegate: self)
        
        view.menu = self.menu
    }
    
    //MARK: Utility
    func log(message: Any) {
        print("[Controller] \(message)")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        log("touches began")
    }
}

class HamburgerMenuControllerView: UIView {
    
    var menu: HamburgerMenu!
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        if CGRectContainsPoint(self.bounds, point) {
            return true
        }
        
        if CGRectContainsPoint(self.menu.frame, point) {
            return true
        }
        
        return false
    }
    
}

extension HamburgerMenuController: HamburgerMenuDelegate {
    
    func openTab(tab: Int) {
        self.selectedIndex = tab
    }
    
}
