import MapKit
import UIKit

class MapViewController: UIViewController {
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
 Chapter5: Programmatic Views - Bronze Challenge p. 216: Points of Interest
 Add a UILabel and UISwitch to the MapViewController interface. The label should say Points of Interest and the switch should toggle the display of points of interest
 on the map (Figure 5.7). You will want to add a target-action pair to the switch that updates the map’s pointOfInterestFilter property.

 You may need to zoom in a bit before points of interest are visible. To zoom in on the simulator, hold down the Option key. Two small circles will appear on the
 simulator screen, representing fingers. Click and drag the virtual fingers apart to zoom in.
*/
        let pointOfInterestLabel = UILabel()
        pointOfInterestLabel.text = "Point of Interest"
        pointOfInterestLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointOfInterestLabel)
        
        pointOfInterestLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
        let pointOfInterestSwitch = UISwitch()
        pointOfInterestSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointOfInterestSwitch)
        pointOfInterestSwitch.isOn = false
        pointOfInterestSwitch.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        pointOfInterestSwitch.leadingAnchor.constraint(equalTo: pointOfInterestLabel.trailingAnchor, constant: 8).isActive = true
        pointOfInterestLabel.centerYAnchor.constraint(equalTo: pointOfInterestSwitch.centerYAnchor).isActive = true
        
        pointOfInterestSwitch.addTarget(self, action: #selector(pointOfInterestToggle(_:)), for: .valueChanged)
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
    
    @objc func pointOfInterestToggle(_ toggle: UISwitch) {
        switch toggle.isOn {
        case true:
            mapVIew.pointOfInterestFilter = .includingAll
        case false:
            mapVIew.pointOfInterestFilter = .excludingAll
        }
    }
}
