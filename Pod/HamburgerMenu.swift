//
//  HamburgerMenu.swift
//  Alexander Black
//
//  Created by Tanner Nelson on 1/13/16.
//  Copyright © 2016 Blue Bite. All rights reserved.
//

import UIKit


protocol HamburgerMenuDelegate {
    func openTab(tab: Int)
}

class HamburgerMenu: UIView {
    
    var rootView: UIView!
    var width: CGFloat!
    var delegate: HamburgerMenuDelegate!
    
    var open = false
    
    var activeTab: Int = 0 {
        didSet {
            self.delegate.openTab(self.activeTab)
        }
    }
    
    class func addTo(rootView: UIView, menuNib: String, delegate: HamburgerMenuDelegate) -> HamburgerMenu {
        //create menu from nib
        guard let menu = UIView.instantiateFromNib(menuNib) as? HamburgerMenu else {
            fatalError("Menu Nib must be of class `HamburgerMenu`")
        }
        
        //calculate a nice width for the menu
        var width = rootView.frame.size.width - 69
        if width > 400 {
            width = 400
        }
        
        //initialize
        menu.width = width
        menu.rootView = rootView
        menu.delegate = delegate
        
        
        //add the menu to the rootView and constrain it to hang off the left side
        menu.rootView.addSubview(menu)
        menu.translatesAutoresizingMaskIntoConstraints = false
        
        //align to edges of super view
        menu.rootView.addConstraint(
            NSLayoutConstraint(item: menu, attribute: .Top, relatedBy: .Equal, toItem: menu.rootView, attribute: .Top, multiplier: 1, constant: 0)
        )
        menu.rootView.addConstraint(
            NSLayoutConstraint(item: menu, attribute: .Trailing, relatedBy: .Equal, toItem: menu.rootView, attribute: .Leading, multiplier: 1, constant: 0)
        )
        menu.rootView.addConstraint(
            NSLayoutConstraint(item: menu, attribute: .Bottom, relatedBy: .Equal, toItem: menu.rootView, attribute: .Bottom, multiplier: 1, constant: 0)
        )
        menu.rootView.addConstraint(
            NSLayoutConstraint(item: menu, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: menu.width)
        )

        return menu
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func toggle() {
        self.open = !self.open
        
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            //calculate whether to open or close the menu
            let left: CGFloat
            if self.open {
                UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
                left = self.width
            } else {
                UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)
                left = 0
            }
            
            self.rootView.transform = CGAffineTransformMakeTranslation(left, 0)
            
        }, completion: nil)
    }
}