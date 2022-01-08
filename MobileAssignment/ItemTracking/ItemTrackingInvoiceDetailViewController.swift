//
//  ItemTrackingInvoiceDetailViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 6/1/2022.
//

import UIKit
import CoreData
import CoreLocation

class ItemTrackingInvoiceDetailViewController: UIViewController {

    let db = firebase.db
    let dbref = firebase.ref
    var isInvoiceExist = false
    
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var residential: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    @IBOutlet weak var frontView: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var topView: UIImageView!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    @IBOutlet weak var noResultFoundView: UIView!
    @IBOutlet weak var noResultFoundLabel: UILabel!
    @IBOutlet weak var noResultFoundIcon: UIImageView!
    @IBOutlet weak var invoiceTrackingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        loadingIcon.startAnimating()
        noResultFoundView.isHidden = true
        view.bringSubviewToFront(invoiceTrackingButton)
        
        checkIfDocExist(completion: {})
        
    }
    
    func fetchData(completion: @escaping () -> Void) {
        fetch("orders", "day", orderDate)
        fetch("orders", "month", orderDate)
        fetch("orders", "date", orderDate)
        fetch("orders", "time", orderTime)
        fetch("orders", "itemName", itemName)
        fetch("orders", "itemPrice", itemPrice)
        fetch("orders", "totalPrice", totalPrice)
        fetch("orders", "emailAddress", emailAddress)
        fetch("orders", "itemQty", itemQty)
        
        
        fetch("shipping", "firstName", firstName)
        fetch("shipping", "lastName", lastName)
        fetch("shipping", "address", address)
        fetch("shipping", "residential", residential)
        fetch("shipping", "city", city)
        fetch("shipping", "country", country)
        fetch("shipping", "zipCode", zipCode)
        
        updateInvoiceTracking("orderDay")
        updateInvoiceTracking("orderMonth")
        updateInvoiceTracking("street")
        updateInvoiceTracking("country")
        
    }
    
    func fetch(_ collection: String, _ field: String, _ label: UILabel) {
        let docRef = db.document("\(collection)/#\(findYourOrder.targetInvoiceNumber)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                label.text = field == "itemPrice" || field == "totalPrice" ? "$\(res)" : field == "itemQty" ? "\(res)x $399" : "\(res)"
                if(field == "address") {
                    invoiceTracking.deliverAddress = res as! String
                }
                if(field == "residential") {
                    invoiceTracking.deliverResidential = res as! String
                }
                if(field == "day") {
                    invoiceTracking.orderDay = res as! Int
                }
                if(field == "month") {
                    invoiceTracking.orderMonth = res as! Int
                }
                
            }
        }
    }
    
    func fetchImages(_ field: String, _ uiimage: UIImageView) {
        let docRef = db.document("orderImages/#\(findYourOrder.targetInvoiceNumber)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                uiimage.image = res as? UIImage
            }
        }
    }
    
    
    func updateInvoiceTracking(_ field: String) {
        let docRef = db.document("\(field == "orderDay" ? "orders" : field == "orderMonth" ? "orders" : "shipping")/#\(findYourOrder.targetInvoiceNumber)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                if(field == "orderDay") {
                    invoiceTracking.orderDay = res as! Int
                }
                if(field == "orderMonth"){
                    invoiceTracking.orderMonth = res as! Int
                }
                if(field == "street") {
                    invoiceTracking.deliverStreet = res as! String
                }
                if(field == "country") {
                    invoiceTracking.deliverCountry = res as! String
                }
            }
        }
    }

    
    // 2022010612034451158
    func checkIfDocExist(completion: @escaping () -> Void) {
        let docRef = db.collection("orders").document("#\(findYourOrder.targetInvoiceNumber)")
        DispatchQueue.main.async {
            docRef.getDocument { (document, error) in
                
                if let document = document, document.exists {
                    print("...exist")
                    self.fetchData(completion: {})
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.8...1.6)) {
                        self.loadingView.isHidden = true
                    }
                    
                } else {
                    self.loadingView.isHidden = true
                    self.noResultFoundView.isHidden = false
                    self.noResultFoundLabel.text = "[ \(findYourOrder.targetInvoiceNumber) ]"
                    self.noResultFoundIcon.alpha = 0.1
                }
            }
        }
    }
}
