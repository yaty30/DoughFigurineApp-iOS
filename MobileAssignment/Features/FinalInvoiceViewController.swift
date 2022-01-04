//
//  FinalInvoiceViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 4/1/2022.
//

import UIKit

class FinalInvoiceViewController: UIViewController {

    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var orderBy: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invoiceNumber.text = invoiceData.invoiceNumber
        orderBy.text = invoiceData.orderBy
        orderDate.text = invoiceData.orderDate
        orderTime.text = invoiceData.orderTime
        itemName.text = invoiceData.items[0]
        itemQty.text = "\(invoiceData.itemQty[0])x\(Double(invoiceData.itemQty[0]) * invoiceData.itemPrices[0])"
        itemPrice.text = "$\(invoiceData.itemPrices[0])"
        totalPrice.text = "$\(invoiceData.totalPrice)"
        emailAddress.text = invoiceData.emailAddress
    }

}
