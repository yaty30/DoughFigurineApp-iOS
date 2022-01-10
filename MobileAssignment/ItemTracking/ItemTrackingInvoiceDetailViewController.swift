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
    var itemQtyText = ""
    var firstNameText = ""
    var lastNameText = ""
    var flat = ""
    var tower = ""
    var residentialText = ""
    var street = ""
    var county = ""
    var district = ""
    var city = ""
    var country = ""

    @IBOutlet weak var mainView: UIScrollView!
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var flatAndTower: UILabel!
    @IBOutlet weak var residential: UILabel!
    @IBOutlet weak var streetName: UILabel!
    @IBOutlet weak var countyAndDistrict: UILabel!
    @IBOutlet weak var cityCountry: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    @IBOutlet weak var frontView: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var topView: UIImageView!
    
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var paidAmount: UILabel!
    @IBOutlet weak var paidOn: UILabel!
    @IBOutlet weak var paidAt: UILabel!
    
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
//        view.bringSubviewToFront(invoiceTrackingButton)
        
        checkIfDocExist(completion: {})
        
    }
    
    func fetchData(completion: @escaping () -> Void) {
        invoiceNumber.text = "Invoice #\(findYourOrder.targetInvoiceNumber)"
        fetch("orders", "day", orderDate)
        fetch("orders", "month", orderDate)
        fetch("orders", "date", orderDate)
        fetch("orders", "time", orderTime)
        fetch("orders", "itemName", itemName)
        fetch("orders", "itemPrice", itemPrice)
        fetch("orders", "totalPrice", totalPrice)
        fetch("orders", "emailAddress", emailAddress)
        fetch("orders", "itemQty", itemQty)
        
        getName(completion: {})
        getAddress(completion: {})
        
        fetch("payment", "paidDate", paidOn)
        fetch("payment", "paidTime", paidAt)
        fetch("payment", "paidAmount", paidAmount)
        fetch("payment", "paymenMethod", paymentMethod)
        
        fetch("shipping", "zipCode", zipCode)
        fetch("shipping", "contactNumber", contactNumber)
        
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
            
            DispatchQueue.main.async { [self] in
                label.text = field == "itemPrice" || field == "totalPrice" ? "$\(res)" : field == "time" ? "at \(res)" : "\(res)"
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
                if(field == "firstName") {
                    self.firstNameText = res as! String
                }
                if(field == "lastName") {
                    self.lastNameText = res as! String
                }
                if(field == "paidAmount") {
                    paidAmount.text = "$\(res)"
                }
                if(field == "itemQty") {
                    itemQtyText = "\(res)x $399"
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
    
    func getName(completion: @escaping () -> Void) {
        func fetchNames(_ field: String) {
            let docRef = db.document("shipping/#\(findYourOrder.targetInvoiceNumber)")
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                
                guard let res = data[field] else { return }
                
                DispatchQueue.main.async {
                    if(field == "firstName") {
                        self.firstNameText = res as! String
                    }
                    if(field == "lastName") {
                        self.lastNameText = res as! String
                    }
                    self.name.text = "\(self.firstNameText) \(self.lastNameText)"
                }
            }
        }
        
        if(lastNameText == "") {
            fetchNames("firstName")
            fetchNames("lastName")
        } else {
            completion()
        }
        
    }
    
    func updateCustomerInfo() {
        name.text = "\(firstNameText) \(lastNameText)"
        flatAndTower.text = "Flat \(flat), Tower\(tower), \(residentialText)"
        streetName.text = street
        countyAndDistrict.text = "\(county), \(district)"
        cityCountry.text = "\(city), \(country)"
//        print(";;;;;;")
    }
    
    func getAddress(completion: @escaping () -> Void) {
        func fetchAddr(_ field: String) {
            let docRef = db.document("shipping/#\(findYourOrder.targetInvoiceNumber)")
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                guard let res = data[field] else { return }
                
                DispatchQueue.main.async {
                    print(res)
                    if(field == "flat") {
                        self.flat = res as! String
                    }
                    if(field == "tower") {
                        self.tower = res as! String
                    }
                    if(field == "residental") {
                        self.residentialText = res as! String
                    }
                    if(field == "streetName") {
                        self.street = res as! String
                    }
                    if(field == "county") {
                        self.county = res as! String
                    }
                    if(field == "district") {
                        self.district = res as! String
                    }
                    if(field == "city") {
                        self.city = res as! String
                    }
                    if(field == "country") {
                        self.country = res as! String
                    }
                    self.updateCustomerInfo()
                }
            }
        }
        
        if(country == "") {
            fetchAddr("flat")
            fetchAddr("tower")
            fetchAddr("residential")
            fetchAddr("streetName")
            fetchAddr("county")
            fetchAddr("district")
            fetchAddr("city")
            fetchAddr("country")
        } else {
            completion()
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