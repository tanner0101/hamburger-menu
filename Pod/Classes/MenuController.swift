/*
    The HamburgerMenuController is a subclass of UITabBarController 
    that takes care of switching active tabs and adding
    the actual HamburgerMenu to a global view.
*/

import UIKit
import HamburgerButton

@IBDesignable
public class MenuController: UITabBarController {

    //MARK: Interface
    
    /**
        The Menu for this controller.
    
        Call `toggle(animated: Bool)` to show/hide the menu.
    */
    public private(set) var menu: MenuView!
    
    //MARK: Properties
    @IBInspectable var menuNib: String!
    var buttons: [Button] = []
    
    
    //MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = MenuControllerView(frame: self.view.frame)
        view.backgroundColor = UIColor.blackColor()
        
        view.addSubview(self.view)
        self.view.constrainToSuperview(view)
        
        self.view = view

        //hide the default tab bar
        self.tabBar.hidden = true
        
        //add the menu
        if self.menuNib == nil || self.menuNib == "" {
            if #available(iOS 9, *) {
                self.menu = DefaultMenuView(rootView: self.view, controller: self)
            } else {
                fatalError("Default Menu is only supported in iOS 9 or later. You must provide a custom menu nib")
            }
        } else {
            guard let menu = UIView.instantiateFromNib(menuNib) as? MenuView else {
                fatalError("Menu Nib '\(menuNib).xib' must exist and be a subclass of `HamburgerMenu`")
            }
            menu.initialize(self.view, controller: self)
            self.menu = menu
        }
        
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                
                let button = HamburgerButton.Button(frame: CGRect(x: 16, y: 17, width: 50, height: 50))
                button.delegate = self
                self.buttons.append(button)
                
                if let navigationController = viewController as? UINavigationController {
                    let barButton = UIBarButtonItem(customView: button)
                    navigationController.viewControllers[0].navigationItem.leftBarButtonItem = barButton
                } else {
                    
                    viewController.view.addSubview(button)
                }
            }
        }
        
        view.menu = self.menu
    }
    
    //MARK: Utility
    func log(message: Any) {
        HamburgerMenu.log("[Controller] \(message)")
    }
    
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let point = touch.locationInView(self.view)
        if CGRectContainsPoint(self.view.bounds, point) {
            if self.menu.open {
                self.menu.toggle(true)
            }
        }
    }
}

extension MenuController: HamburgerButton.ButtonDelegate {

    public func hamburgerButtonPressed(button: Button) {
        self.menu.toggle(true)
    }
    
}
