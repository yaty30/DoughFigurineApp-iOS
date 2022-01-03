//
//  ConfirmAndPayController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class ConfirmAndPayController: UIViewController {

    @IBOutlet weak var applePayButton: UIButton!
//    @IBOutlet weak var invoiceID: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderBy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        invoiceID.text = self.generateInvoiceID()
        orderBy.text = "current_user"
        orderDate.text = self.getOrderTimeAndDate(type: "orderDate")
        orderTime.text = self.getOrderTimeAndDate(type: "orderTime")
    }
    
    func generateInvoiceID() -> String {
        let date = Date()
        let format = DateFormatter()
        
        format.dateFormat = "yyyyMMddHHmmss"
        
        let invoiceID = format.string(from: date)
        let addon = self.randomString(length: 5)
        
        return "#\(invoiceID)\(addon)"
    }
    
    func getOrderTimeAndDate(type: String) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = type == "orderDate" ? "yyyy-MM-dd" : "HH:mm:ss"
        
        let result = format.string(from: date)
        
        return "\(result)"
    }
    
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
}