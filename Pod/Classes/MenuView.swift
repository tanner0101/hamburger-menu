/*
    The main Menu view.

    Subclass this view and create a nib that 
    uses the subclass you created.

    Import this nib into your MenuController
    in the Storyboard under "Menu Nib"
*/

import UIKit

public class MenuView: UIView {
    
    //MARK: Properties
    var rootView: UIView!
    var width: CGFloat!
    var open = false
    
    ///The HamburgerMenuController this menu is attached to
    public var controller: MenuController!
   
    init(rootView: UIView, controller: MenuController) {
        self.init()
        
        self.initialize(rootView, controller: controller)
    }
    
    func initialize(rootView: UIView, controller: MenuController) {
        //calculate a nice width for the menu
        var width = rootView.frame.size.width - 85
        if width > 400 {
            width = 400
        }
        
        //initialize
        self.width = width
        self.rootView = rootView
        self.controller = controller
        
        //add the menu to the rootView and constrain it to hang off the left side
        self.rootView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //align to edges of super view
        self.rootView.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: self.rootView, attribute: .Top, multiplier: 1, constant: 0)
        )
        self.rootView.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: self.rootView, attribute: .Leading, multiplier: 1, constant: 0)
        )
        self.rootView.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: self.rootView, attribute: .Bottom, multiplier: 1, constant: 0)
        )
        self.rootView.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: self.width)
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func switchToTab(tab: Int, andClose shouldClose: Bool) {
        self.controller.selectedIndex = tab
        
        if self.open && shouldClose {
            self.toggle(true)
        }
    }
    
    ///Open and close the menu and transition all HamburgerButtons. Animation is optional.
    public func toggle(animated: Bool) {
        self.open = !self.open
        
        for button in self.controller.buttons {
            if self.open {
                button.transitionToHamburger(false)
                button.transitionToX(animated)
            } else {
                button.transitionToX(false)
                button.transitionToHamburger(animated)
            }
        }
        
        if animated {
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.toggleTransform()
            }, completion: nil)
        } else {
            self.toggleTransform()
        }
    }
    
    func toggleTransform() {
        //calculate whether to open or close the menu
        let left: CGFloat
        if self.open {
            left = self.width
        } else {
            left = 0
        }
        
        self.rootView.transform = CGAffineTransformMakeTranslation(left, 0)
    }
}