//
//  FinalInvoiceViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 4/1/2022.
//

import UIKit

class FinalInvoiceViewController: UIViewController {
    
    let db = firebase.db
//
//    @IBOutlet weak var invoiceNumber: UILabel!
//    @IBOutlet weak var orderDate: UILabel!
//    @IBOutlet weak var orderTime: UILabel!
//
//    @IBOutlet weak var itemName: UILabel!
//    @IBOutlet weak var itemPrice: UILabel!
//    @IBOutlet weak var itemQty: UILabel!
//    @IBOutlet weak var totalPrice: UILabel!
//
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var emailAddress: UILabel!
//    @IBOutlet weak var contactNumber: UILabel!
//    @IBOutlet weak var flatAndTower: UILabel!
//    @IBOutlet weak var streetName: UILabel!
//    @IBOutlet weak var countyAndDistrict: UILabel!
//    @IBOutlet weak var cityAndCountry: UILabel!
//    @IBOutlet weak var zipCode: UILabel!
//
//    @IBOutlet weak var paymentMethod: UILabel!
//    @IBOutlet weak var paidAmount: UILabel!
//    @IBOutlet weak var paidOn: UILabel!
//    @IBOutlet weak var paidAt: UILabel!
    
    
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var flatAndTower: UILabel!
    @IBOutlet weak var streetName: UILabel!
    @IBOutlet weak var countyAndDistrict: UILabel!
    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var paidAmount: UILabel!
    @IBOutlet weak var paidOn: UILabel!
    @IBOutlet weak var paidAt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getInvoiceInfo()
        getShippingInfo()
        getPaymentInfo()
        
    }
    
    func getInvoiceInfo() {
        invoiceNumber.text = "Invoice \(invoiceData.invoiceNumber)"
        orderDate.text = invoiceData.orderDate
        orderTime.text = "at \(invoiceData.orderTime)"
        itemName.text = invoiceData.items[0]
        itemQty.text = invoiceData.itemQty[0]
        itemPrice.text = "$\(invoiceData.itemPrices[0])"
        totalPrice.text = "$\(invoiceData.totalPrice)"
    }
    
    func getShippingInfo() {
        name.text = "\(shippingInfo.firstName) \(shippingInfo.lastName)"
        emailAddress.text = invoiceData.emailAddress
        contactNumber.text = invoiceData.contactNumber
        
        let towerIsNil = shippingInfo.tower == "" ? "" : ", Tower \(shippingInfo.tower)"
        flatAndTower.text = "Flat \(shippingInfo.floor)\(shippingInfo.flat)\(towerIsNil), \(shippingInfo.residential)"
        
        streetName.text = shippingInfo.streetName
        
        countyAndDistrict.text = "\(shippingInfo.county), \(shippingInfo.district)"
        
        cityAndCountry.text = "\(shippingInfo.city), \(shippingInfo.country)"
        
        zipCode.text = shippingInfo.zipCode
    }
    
    func getPaymentInfo() {
        paymentMethod.text = orderPayment.paymentMethod
        paidAmount.text = "$\(orderPayment.paidAmount)"
        paidOn.text = invoiceData.orderDate
        paidAt.text = invoiceData.orderTime
    }

}
