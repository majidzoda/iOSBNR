

import UIKit

class ConversionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    //Chapter4: View Controllers - Silver Challenge p. 195
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let colors = [UIColor.red,
                      UIColor.yellow,
                      UIColor.green,
                      UIColor.blue]
        view.backgroundColor = colors.randomElement()
        
        
    }
}

/*
Chapter4: View Controllers - Bronze Challenge p. 194: Another Tab
Add a third tab to the WorldTrotter application. This tab should show the Quiz interface that you created
in Chapter 1. A few notes to help you along:
    In Chapter 1, the view controller’s name is ViewController. Consider renaming it to
    QuizViewController.
 
    You can drag the QuizViewController.swift file (or ViewController.swift, if you did not rename it)
    from Finder into the WorldTrotter application in Xcode. When you do, make sure you check the Copy
    items if needed checkbox to make a copy of the file, rather than moving it.
    
    You can copy the view controller scene from the storyboard in the Quiz project to the storyboard in
    the WorldTrotter project.
*/

/*
Chapter4: View Controllers - Silver Challenge p. 195
Different Background Colors
Whenever the ConversionViewController is viewed, update its background color to be a randomly generated
color. Hint: You will need to override viewWillAppear(_:) to accomplish this.
 */
