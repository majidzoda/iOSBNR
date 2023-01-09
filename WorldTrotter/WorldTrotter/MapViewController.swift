import MapKit
import UIKit

class MapViewController: UIViewController {
    var mapVIew: MKMapView!
    override func loadView() {
        // Create a map view
        mapVIew = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapVIew
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
}
