import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var viewedLabel: UILabel!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
                self.viewedLabel.text = "viewed \(self.photo.vitewsTotal) many times"
                
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}
