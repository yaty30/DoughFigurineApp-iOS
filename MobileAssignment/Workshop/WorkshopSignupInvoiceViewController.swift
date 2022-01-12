//
//  WorkshopSignupInvoiceViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import UIKit

class WorkshopSignupInvoiceViewController: UIViewController {

    let db = firebase.db
    var firstname = ""
    var firstNameText = ""
    var lastNameText = ""
    
    @IBOutlet weak var workshopTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    @IBOutlet weak var signupID: UILabel!
    @IBOutlet weak var pax: UILabel!
    @IBOutlet weak var timeslot: UILabel!
    
    @IBOutlet weak var signupDate: UILabel!
    @IBOutlet weak var signupTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(workshopSignup.workshopSignupID)
        fetch()
        getName(completion: {})
    }
    
    func fetch() {
        signupID.text = workshopSignup.workshopSignupID
        
        fetchSignupRecord("workshop", workshopTitle)
        fetchSignupRecord("emailAddress", emailAddress)
        fetchSignupRecord("contactNumber", contactNumber)
        
        fetchSignupRecord("pax", pax)
        fetchSignupRecord("selectedTimesplot", timeslot)
        
        fetchSignupRecord("signupDate", signupDate)
        fetchSignupRecord("signupTime", signupTime)
    }
    
    func fetchSignupRecord(_ field: String, _ label: UILabel) {
        let docRef = db.document("workshopSignup/\(workshopSignup.workshopSignupID)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                if(field == "lastname") {
                    self.name.text = "\(self.firstname) \(res)"
                }
                label.text = "\(res)"
            }
        }
    }
    
    func getName(completion: @escaping () -> Void) {
        func fetchNames(_ field: String) {
            let docRef = db.document("workshopSignup/\(workshopSignup.workshopSignupID)")
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

}
