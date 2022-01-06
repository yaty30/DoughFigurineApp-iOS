//
//  ItemTrackingInvoiceDetailViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 6/1/2022.
//

import UIKit

class ItemTrackingInvoiceDetailViewController: UIViewController {

    let db = firebase.db
    
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
    
    @IBOutlet weak var invoiceTrackingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        loadingIcon.startAnimating()
        view.bringSubviewToFront(invoiceTrackingButton)
        
        fetchFindOrderData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.8...1.4)) {
            self.loadingView.isHidden = true
        }
    }
    
    func fetchFindOrderData() {
        fetch("orders", "date", orderDate)
        fetch("orders", "time", orderTime)
        fetch("orders", "itemName", itemName)
        fetch("orders", "itemPrice", itemPrice)
        // fetch("orders", "itemQty", itemQty)
        fetch("orders", "totalPrice", totalPrice)
        fetch("orders", "emailAddress", emailAddress)
        itemQty.text = "\(fetch("orders", "itemQty", itemQty))"
        
        
        fetch("shipping", "firstName", firstName)
        fetch("shipping", "lastName", lastName)
        fetch("shipping", "address", address)
        fetch("shipping", "residential", residential)
        fetch("shipping", "city", city)
        fetch("shipping", "country", country)
        fetch("shipping", "zipCode", zipCode)
        

    }
    
    func fetch(_ collection: String, _ field: String, _ label: UILabel) {
        let docRef = db.document("\(collection)/#\(findYourOrder.targetInvoiceNumber)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                label.text = field == "itemPrice" || field == "totalPrice" ? "$\(res)" : field == "itemQty" ? "\(res)x $399" : "\(res)"
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
    
}
