//
//  WorkshopContentViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class WorkshopContentViewController: UIViewController {
    
    let db = firebase.db

    var addressForMap = ""

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var workshopTitle: UILabel!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var overviewOne: UILabel!
    @IBOutlet weak var overviewTwo: UILabel!
    @IBOutlet weak var overviewThree: UILabel!
    
    @IBOutlet weak var workshopDate: UILabel!
    @IBOutlet weak var workshopTimeOne: UILabel!
    @IBOutlet weak var workshopTimeTwo: UILabel!
    @IBOutlet weak var approximatelyHours: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var venueMap: MKMapView!
    
    @IBOutlet weak var ticketFee: UILabel!
    @IBOutlet weak var ticketFeeCaption: UILabel!
    @IBOutlet weak var ticketDescriptionOne: UILabel!
    @IBOutlet weak var ticketDescriptionTwo: UILabel!
    
    
    @IBOutlet weak var language: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetch(done: {})
    }
    
    func fetch(done: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.fetchData("date", self.date)
            self.fetchData("name", self.workshopTitle)
            self.fetchData("dayWithWeekDay", self.workshopDate)
            self.fetchData("approximatelyHours", self.approximatelyHours)
            self.fetchData("address", self.venue)
            self.fetchData("venue", self.venue)
            self.fetchData("ticketFee", self.ticketFee)
            self.fetchData("ticketFeeCaption", self.ticketFeeCaption)
            self.fetchData("language", self.language)
            
            self.fetchArray("overview", self.overviewOne, 0)
            self.fetchArray("overview", self.overviewTwo, 1)
            self.fetchArray("overview", self.overviewThree, 2)
            
            self.fetchArray("times", self.workshopTimeOne, 0)
            self.fetchArray("times", self.workshopTimeTwo, 1)
            
            self.fetchArray("ticketDescription", self.ticketDescriptionOne, 0)
            self.fetchArray("ticketDescription", self.ticketDescriptionTwo, 1)
            
            done()
        }
    }
    
    
    func fetchData(_ field: String, _ label: UILabel) {
        let docRef = db.document("workshops/RGJ109")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                if(field == "address") {
                    self.addressForMap = res as! String
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...0.9)) {
                        self.mapCreate(done: {})
                    }
                }
                label.text = field == "ticketFee" ? "HK$\(res) per person" : field == "approximatelyHours" ? "Approximately \(res) \(res as! Int > 1 ? "hours" : "hour")" : "\(res)"
            }
        }
    }
    
    func fetchArray(_ field: String, _ label: UILabel, _ index: Int) {
        let docRef = db.document("workshops/RGJ109")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            let arr = res as? NSArray
            DispatchQueue.main.async {
                label.text = "\(arr![index])"
            }
        }
    }
    
    func fetchImage(_ field: String, _ uiimage: UIImageView) {
        let docRef = db.document("workshops/\(findYourOrder.targetInvoiceNumber)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                let base64str = res as? String ?? ""
                let imageData = Data(base64Encoded: base64str)
                uiimage.image = UIImage(data: imageData!)
            }
        }
    }

    func mapCreate(done: @escaping () -> Void) {
        venueMap.removeAnnotations(venueMap.annotations)
        print("addressForMap: ", addressForMap)
        LocationManager.shared.findLocation(with: addressForMap) { [weak self] locations in
            DispatchQueue.main.async {
                let pin = MKPointAnnotation()
                print(locations)
                pin.coordinate = locations[0].Coordinates!

                pin.title = "Workshop Venue"
                self!.venueMap.addAnnotation(pin)

                let region = MKCoordinateRegion(center: locations[0].Coordinates!, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                self!.venueMap.setRegion(region, animated: true)

                done()
            }
        }
    }
}
