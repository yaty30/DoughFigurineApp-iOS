//
//  ItemTrackingViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 5/1/2022.
//

import UIKit

class ItemTrackingViewController: UIViewController, UITextFieldDelegate {

    let db = firebase.db
    
    @IBOutlet weak var serachBarIconView: UIView!
    @IBOutlet weak var invoiceSerachBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serachBarIconView?.alpha = 0.1

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.invoiceSerachBar?.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("clicked")
        return false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func getData(_ collection: String, _ field: String) -> String {
        var result = ""
        db.collection(collection).document(invoiceData.invoiceNumber).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.get(field)
                result = dataDescription as? String ?? "_no_data_found_"
            } else {
                result = "Fetch data failed: Document does not exist."
            }
        }
        
        return result
    }
    
    func fetchInvoiceData() {
//        invoiceNumber.text = invoiceData.invoiceNumber
//        orderBy.text = getData("orders", "orderBy")
//        orderDate.text = getData("orders", "date")
//        orderTime.text = getData("orders", "time")
//        itemName.text = getData("orders", "itemName")
//        itemQty.text = "\(invoiceData.itemQty[0])x\(Double(invoiceData.itemQty[0]) * invoiceData.itemPrices[0])"
//        itemPrice.text = "$\(getData("orders", "itemPrice"))"
//        totalPrice.text = "$\(getData("orders", "totalPrice"))"
//        emailAddress.text = getData("orders", "emailAddress")
    }

}
