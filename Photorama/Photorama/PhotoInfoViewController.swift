import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var favoritesDataStore: PhotoDataSource!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayFavorite()
        store.fetchImage(for: photo) { (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
                
            }
        }
    }
    
    private func displayFavorite(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: photo.isFavorite ? "star.fill" : "star"), style: .plain, target: self, action: #selector(favoritePhoto))
    }
    
    @objc func favoritePhoto(){
        photo.isFavorite = !photo.isFavorite
        try? store.persistantContainer.viewContext.save()
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: photo.isFavorite ? "star.fill" : "star")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags":
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            
            tagController.store = store
            tagController.photo = photo
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
