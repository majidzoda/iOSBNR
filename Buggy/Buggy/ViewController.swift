import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchToggle(_ sender: UISwitch) {
        print("Called buttonTapped(_:)")
    }
}
