import UIKit
class PhotosViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var favoriteSegment: UISegmentedControl!
    @IBOutlet private var noFavePhotosLabel: UILabel!
    
    var store: PhotoStore!
    var favoritesDataSource = PhotoDataSource()
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        updateDataSource()
        
        store.fetchInterestingPhotos {
            (photoResult) in
            self.updateDataSource()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDataSource()
    }
    
    private func updateDataSource() {
        store.fetchAllPhotos {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
                if self.favoriteSegment.selectedSegmentIndex == 0 {
                    self.photoDataSource.photos = photos
                } else {
                    self.photoDataSource.photos = photos.filter { $0.isFavorite }
                }
            case .failure:
                self.photoDataSource.photos.removeAll()
            }

            
            if self.photoDataSource.photos.count == 0 {
                self.noFavePhotosLabel.text = "No Favorite Photos"
            } else {
                self.noFavePhotosLabel.text = ""
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    @IBAction func favoriteSegmentControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            updateDataSource()
        case 1:
            updateDataSource()
        default:
            preconditionFailure("Invalid segment index.")
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data, wich could take some time
        store.fetchImage(for: photo) { result in
            // The index path for the photo might have changed between
            // the time the request started and finished, so find the most
            // recent index path
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                      return
                  }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(displaying: image)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto":
            if let selectedIndex = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndex.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
