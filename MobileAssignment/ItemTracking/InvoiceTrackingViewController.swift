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
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapCreate(done: {
            let panel = FloatingPanelController()
            panel.set(contentViewController: TrackingInformationViewController())
            panel.addPanel(toParent: self)
            panel.move(to: .tip, animated: true)
        })
    }
    
    func mapCreate(done: @escaping () -> Void) {
        mapView.removeAnnotations(mapView.annotations)
        LocationManager.shared.findLocation(with: "\(invoiceTrackingAddress.street)") { [weak self] locations in
            DispatchQueue.main.async {
                let pin = MKPointAnnotation()
                
                
                // --- maybe its the problem of Apple map, some places can be searched on the app,
                    pin.coordinate = locations[0].Coordinates!
                // but cannot be translated to coordinates from address string. ---
                // for example, like my place 23 Tong Chun St, Tseung Kwan O, it shows the incorrect point of map, however, it works on Google Maps precisely, yet Google map API costs 200 usd per month.
                
                
                pin.title = "Shipping Address"
                self!.mapView.addAnnotation(pin)
                
                let region = MKCoordinateRegion(center: locations[0].Coordinates!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self!.mapView.setRegion(region, animated: true)
                
                invoiceTracking.destinationPoint = CLLocation(latitude: locations[0].Coordinates!.latitude, longitude: locations[0].Coordinates!.longitude)
                
                done()
            }
        }
    }
    
}
