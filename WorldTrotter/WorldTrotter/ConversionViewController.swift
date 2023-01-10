

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
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
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
