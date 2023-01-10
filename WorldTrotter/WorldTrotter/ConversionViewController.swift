

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    @IBAction func frenheitFieltEditingChanged(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty{
            celsiusLabel.text = textField.text
        } else {
            celsiusLabel.text = "???"
        }
        
    }
}

