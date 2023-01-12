import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: UISwitch) {
        print("Called buttonTapped(_:)")
        // Log sender:
        print("sender \(sender)")
        // Log the control state:
        print("Is control on ? \(sender.isOn)")
    }
}
