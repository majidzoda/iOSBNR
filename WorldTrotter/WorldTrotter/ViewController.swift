

import UIKit

class ViewController: UIViewController {
/*
Chapter3: Views - Silver Challenge: Adding a Gradient Layer p. 161
You learned in this chapter that all UIView instances are backed by a CALayer. Every view hierarchy is
backed by a corresponding layer hierarchy, and you can create and add sublayers just as you can create
and add subviews.
    
Use a CAGradientLayer to add a gradient to the background of the view controller (Figure 3.27). You will
want this layer to be positioned behind the labels. For this challenge, you will want to consult the
documentation for both CALayer and its subtype CAGradientLayer.
*/
    let gradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors = [UIColor.blue.cgColor,
                                UIColor.green.cgColor,
                                UIColor.yellow.cgColor,
                                UIColor.red.cgColor,
                                ]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
}


