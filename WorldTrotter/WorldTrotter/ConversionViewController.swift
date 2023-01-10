

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
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
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
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
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celciusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    /*
    Chapter6: Text Input and Delegation - Bronze Challenge p. 251: Disallow Alphabetic Characters
    Currently, the user can enter alphabetic characters either by using a Bluetooth keyboard or by
    pasting copied text into the text field. Fix this issue. Hint: You will want to use the CharacterSet
    type.
     */
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeperator = string.range(of: ".")
        /*
        Chapter6: Text Input and Delegation - Bronze Challenge p. 251: Disallow Alphabetic Characters
        Currently, the user can enter alphabetic characters either by using a Bluetooth keyboard or by
        pasting copied text into the text field. Fix this issue. Hint: You will want to use the CharacterSet
        type.
         */
        let replacementIsNumber = CharacterSet(charactersIn: string).isSubset(of: CharacterSet.letters)
        if (existingTextHasDecimalSeperator != nil && replacementTextHasDecimalSeperator != nil) || (replacementIsNumber && string != ""){
            return false
        } else {
            return true
        }
    }
}
