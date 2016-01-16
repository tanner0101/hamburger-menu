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
   
    class func addTo(rootView: UIView, menuNib: String, controller: MenuController) -> MenuView {
        //create menu from nib
        guard let menu = UIView.instantiateFromNib(menuNib) as? MenuView else {
            fatalError("Menu Nib must be a subclass of `HamburgerMenu`")
        }
        
        return MenuView.addTo(rootView, menuView: menu, controller: controller)
    }
    
    class func addTo(rootView: UIView, menuView menu: MenuView, controller: MenuController) -> MenuView  {
        
        //calculate a nice width for the menu
        var width = rootView.frame.size.width - 69
        if width > 400 {
            width = 400
        }
        
        //initialize
        menu.width = width
        menu.rootView = rootView
        menu.controller = controller
        
        
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
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func switchToTab(tab: Int, andClose shouldClose: Bool) {
        self.controller.selectedIndex = tab
        
        if self.open && shouldClose {
            self.toggle()
        }
    }
    
    public func toggle() {
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