import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapVIew: MKMapView!
    override func loadView() {
        // Create a map view
        mapVIew = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapVIew
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        /*
         Chapter6: Text Input and Delegation - Silver Challenge p. 252: Displaying the User’s Region
         Display and zoom in on the user’s location on the map. MKMapView has a mechanism for displaying a blue dot annotation on the
         map, but there is no built-in way to zoom in on that location. To get this to work, you will need to do a few things:
         
            Add a “Privacy – Location When In Use Usage Description” key to your application’s Info.plist. This key is associated with
            a description that tells your users why you will be accessing their location information. See Chapter 15 for another
            example of adding a privacy description to your applications.
         
            Ask the user for permission to find their location. You will need to add a property to MapViewController for a
            CLLocationManager instance and call requestWhenInUseAuthorization() when the MapViewController’s view appears. This will
            present an alert to the user with the usage description requesting their permission to get their location.
         
            Use the user’s location to zoom in on their map region. To do this, assign the map’s delegate property. Look through the
            documentation for MKMapViewDelegate and find the appropriate callback to get informed when the user’s location has been
            updated. Implement this method to set the region on the map, either directly or using setRegion(_:animated:).
         */
        
        mapVIew.delegate = self
        CLLocationManager().requestWhenInUseAuthorization()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapVIew.mapType = .standard
        case 1:
            mapVIew.mapType = .hybrid
        case 2:
            mapVIew.mapType = .satellite
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("update location")
        let mapCam = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate, fromDistance: 2.0, pitch: 2.0, heading: 2.0)
        mapView.setCamera(mapCam, animated: true)
       
        
    }
}
