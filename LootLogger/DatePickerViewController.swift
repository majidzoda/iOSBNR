import UIKit
class DatePickerViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker!
    var item: Item!
    
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        item.dateCreated = datePicker.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        datePicker.maximumDate = Date()
        datePicker.setDate(item.dateCreated, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
}
