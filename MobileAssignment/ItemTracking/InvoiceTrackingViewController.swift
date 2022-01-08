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

class InvoiceTrackingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let db = firebase.db
    let gps = CLLocationManager()
    var distanceInKM = 0.00
    let fullAddress = "\(invoiceTracking.deliverResidential), \(invoiceTracking.deliverAddress), \(invoiceTracking.deliverCountry)"
    var orderMonth = ""
    var orderDay = ""
    var destination: CLLocation? = nil
    
    @IBOutlet weak var informationView: UIView!
    
    @IBOutlet weak var distanceFromDeliver: UILabel!
    @IBOutlet weak var deliverWithin: UILabel!
    @IBOutlet weak var deliverAddress: UILabel!
    @IBOutlet weak var estimatedArrival: UILabel!
    
    var locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInformation()
        
    }

   
    func getInformation() {
        let deliverPoint = CLLocation(latitude: 22.507022312898645, longitude: 114.17998710790208)
        
        distanceInKM = 0//round((deliverPoint.distance(from: destination!) / 1000) * 100) / 100.0
        
        distanceFromDeliver.text = "around \(distanceInKM) km"
        
        let days = Int(floor(distanceInKM / 14.54))
        deliverWithin.text = days < 1 ? "< 1 day" : "~\(days) \(days > 1 ? "days" : "day")"
        
        deliverAddress.text = fullAddress
        
        let estimatedDay = Int(invoiceTracking.orderDay) ?? 0 + days
        let estimatedMonth = getMonthName(invoiceTracking.orderMonth)
        
        estimatedArrival.text = "\(estimatedDay) \(estimatedMonth)"
    }
    
    var placemark: CLPlacemark!
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
        
//        let address = "Monterey Tseung Kwan O"
//
//        getCoordinateFrom(address: address) { coordinate, error in
//            guard let coordinate = coordinate, error == nil else { return }
//            // don't forget to update the UI from the main thread
//            DispatchQueue.main.async {
//                print(address, "Location:", coordinate) // Rio de Janeiro, Brazil Location: CLLocationCoordinate2D(latitude: -22.9108638, longitude: -43.2045436)
//            }
//
//        }
    }
    
    @IBAction func dismissCurrentView(_ sender: Any) {

    }
    
    // 2022010612034451158

}
