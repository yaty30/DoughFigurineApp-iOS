//
//  ViewController.swift
//  Directions
//
//  Created by Mac on 9/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TestViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

//    @IBOutlet var textFieldForAddress: UITextField!
//    @IBOutlet var getDirectionsButton: UIButton!
//    @IBOutlet var map: MKMapView!
    
    @IBOutlet weak var textFieldForAddress: UITextField!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    var locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        map.delegate = self
        
    }

    @IBAction func getDirectionsTapped(_ sender: Any) {
        getAddress()
    }
    
    
    func getAddress() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textFieldForAddress.text!) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
                else {
                    print("No Location Found")
                    return
            }
            print(location)
            self.mapThis(destinationCord: location.coordinate)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCord : CLLocationCoordinate2D) {
        
        let souceCordinate = (locationManger.location?.coordinate)!
        
        let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: soucePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is wrong :(")
                }
                return
            }
            
          let route = response.routes[0]
          self.map.addOverlay(route.polyline)
          self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
   
    
}

