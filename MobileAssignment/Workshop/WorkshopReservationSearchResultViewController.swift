//
//  WorkshopReservationSearchResultViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class WorkshopReservationSearchResultViewController: UIViewController {

    let db = firebase.db
    var firstNameText = ""
    var lastNameText = ""
    var addressForMap = ""
    var id = workshopResevationSearch.id
    var paxCal = 1
    
    @IBOutlet weak var workshopTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    @IBOutlet weak var signupID: UILabel!
    @IBOutlet weak var pax: UILabel!
    @IBOutlet weak var workshopTime: UILabel!
    
    @IBOutlet weak var signupDate: UILabel!
    @IBOutlet weak var signupTime: UILabel!
    
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var ticketFee: UILabel!
    @IBOutlet weak var totalFee: UILabel!
    
    @IBOutlet weak var venueMap: MKMapView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var outterLoadingView: UIView!
    @IBOutlet weak var outterLoading: UIActivityIndicatorView!
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var noResultLabel: UILabel!
    @IBOutlet weak var noResultFoundIcon: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outterLoadingView.isHidden = false
        outterLoading.startAnimating()
        loading.startAnimating()
        print(id)
        checkIfDocExist(completion: {})
    }
    
    func fetch(done: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.fetchSignupRecord("workshop", self.workshopTitle)
            self.fetchSignupRecord("emailAddress", self.emailAddress)
            self.fetchSignupRecord("contactNumber", self.contactNumber)
            
            self.fetchSignupRecord("pax", self.pax)
            self.fetchSignupRecord("selectedTimesplot", self.workshopTime)
            
            self.fetchSignupRecord("signupDate", self.signupDate)
            self.fetchSignupRecord("signupTime", self.signupTime)
            
            self.fetchSignupRecord("address", self.venue)
            self.fetchSignupRecord("venue", self.venue)
            self.fetchSignupRecord("ticketFee", self.ticketFee)
            self.fetchSignupRecord("totalFee", self.totalFee)
            
            done()
        }
    }
    
    func fetchSignupRecord(_ field: String, _ label: UILabel) {
        let docRef = db.document("workshopSignup/\(id)")
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
                label.text = field == "ticketFee" || field == "totalFee" ? "$\(res)" : "\(res)"
            }
        }
    }
    
    
    func getName(completion: @escaping () -> Void) {
        func fetchNames(_ field: String) {
            let docRef = db.document("workshopSignup/\(id)")
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                
                guard let res = data[field] else { return }
                
                DispatchQueue.main.async {
                    if(field == "firstname") {
                        self.firstNameText = res as! String
                    }
                    if(field == "lastname") {
                        self.lastNameText = res as! String
                    }
                    self.name.text = "\(self.firstNameText) \(self.lastNameText)"
                }
            }
        }
        
        if(lastNameText == "") {
            fetchNames("firstname")
            fetchNames("lastname")
        } else {
            completion()
        }
        
    }
    
    func checkIfDocExist(completion: @escaping () -> Void) {
        let docRef = db.collection("workshopSignup").document(id)
        DispatchQueue.main.async {
            docRef.getDocument { (document, error) in
                
                if let document = document, document.exists {
                    print("...exist")
                    self.fetch(done: {
                        self.signupID.text = self.id
                        self.getName(completion: {})
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.3...1.7)) {
                            self.outterLoadingView.isHidden = true
                        }
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...0.9)) {
                        self.outterLoadingView.isHidden = true
                    }
                    
                } else {
                    self.outterLoadingView.isHidden = true
                    self.noResultView.isHidden = false
                    self.noResultLabel.text = "[ \(self.id) ]"
                    self.noResultFoundIcon.alpha = 0.1
                }
            }
        }
    }
    
    func mapCreate(done: @escaping () -> Void) {
        venueMap.removeAnnotations(venueMap.annotations)
        LocationManager.shared.findLocation(with: addressForMap) { [weak self] locations in
            DispatchQueue.main.async {
                let pin = MKPointAnnotation()
                print(locations)
                pin.coordinate = locations[0].Coordinates!

                pin.title = "Workshop Venue"
                self!.venueMap.addAnnotation(pin)

                let region = MKCoordinateRegion(center: locations[0].Coordinates!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self!.venueMap.setRegion(region, animated: true)

                done()
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        workshopResevationSearch.id = ""
    }
    
}
