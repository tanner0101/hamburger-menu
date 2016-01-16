//
//  DefaultMenu.swift
//  Pods
//
//  Created by Tanner Nelson on 1/16/16.
//
//

import Foundation

@available(iOS 9 , *)
class DefaultMenuView: MenuView {
    
    override init(rootView: UIView, controller: MenuController) {
        super.init(rootView: rootView, controller: controller)
        
        self.backgroundColor = UIColor.whiteColor()
        
        let stackView = UIStackView()
        stackView.axis = .Vertical
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //align to edges of super view
        self.addConstraint(
            NSLayoutConstraint(item: stackView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 20)
        )
        self.addConstraint(
            NSLayoutConstraint(item: stackView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        )
       
        self.addConstraint(
            NSLayoutConstraint(item: stackView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        )
        
        if let items = controller.tabBar.items {
            for (index, item) in items.enumerate() {
                let button = UIButton()
                
                button.contentHorizontalAlignment = .Left
                button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
                
                button.setTitleColor(controller.view.tintColor, forState: .Normal)
                button.setTitle(item.title, forState: .Normal)
                button.tag = index
                button.addTarget(self, action: Selector("buttonTap:"), forControlEvents: .TouchUpInside)
                stackView.addArrangedSubview(button)
                
            }
        }
        
    }
    
    func buttonTap(sender: UIButton) {
        self.switchToTab(sender.tag, andClose: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}