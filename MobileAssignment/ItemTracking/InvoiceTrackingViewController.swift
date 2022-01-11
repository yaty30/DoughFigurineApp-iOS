//
//  InvoiceTrackingViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 6/1/2022.
//

import UIKit
import CoreData
import CoreLocation
import MapKit
import FloatingPanel

class InvoiceTrackingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let db = firebase.db
    var distanceInKM = 0.00
    let fullAddress = "\(invoiceTracking.deliverResidential), \(invoiceTracking.deliverAddress), \(invoiceTracking.deliverCountry)"
    var orderMonth = ""
    var orderDay = ""
    var destination: CLLocationCoordinate2D? = nil
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        invoiceNumber.text = "Invoice #\(findYourOrder.targetInvoiceNumber)"
        
        let panel = FloatingPanelController()
        panel.set(contentViewController: TrackingInformationViewController())
        panel.addPanel(toParent: self)
        panel.move(to: .tip, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        LocationManager.shared.findLocation(with: "Chateau de peak") { [weak self] locations in
            DispatchQueue.main.async {
                let pin = MKPointAnnotation()
                pin.coordinate = locations[0].Coordinates!
                self!.mapView.addAnnotation(pin)
                
                let region = MKCoordinateRegion(center: locations[0].Coordinates!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self!.mapView.setRegion(region, animated: true)
                
                    
            }
        }
        
        
    }
    
//    var placemark: CLPlacemark!
//
//    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
//        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
//    }
}
