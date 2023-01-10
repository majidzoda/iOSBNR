

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var farenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celciusValue: Measurement<UnitTemperature>? {
        if let farenheitValue = farenheitValue {
            return farenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
    }
    
    @IBAction func frenheitFieltEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text){
            farenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel()  {
        if let celciusValue = celciusValue {
            celsiusLabel.text = "\(celciusValue.value)"
        } else {
            celsiusLabel.text = "???"
        }
    }
}
