import UIKit

extension UIView {
    
    ///Instantiate a UIView object from a nib in the NSBundle.
    class func instantiateFromNib(nibName: String) -> UIView {
        let view = UIView()
        
        let elements = NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)
        for element in elements {
            if let element = element as? UIView {
                return element
            }
        }
        
        return view
    }
    
    ///Constrain a subview to all the edges of its superview with one line.
    func constrainToSuperview(superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //align to edges of super view
        superview.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: superview, attribute: .Top, multiplier: 1, constant: 0)
        )
        superview.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: superview, attribute: .Right, multiplier: 1, constant: 0)
        )
        superview.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: superview, attribute: .Bottom, multiplier: 1, constant: 0)
        )
        superview.addConstraint(
            NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: superview, attribute: .Left, multiplier: 1, constant: 0)
        )
        
    }
    
}
