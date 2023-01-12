import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: UISwitch) {
        sender.isOn = false
        print("Called buttonTapped(_:)")
    }
}
