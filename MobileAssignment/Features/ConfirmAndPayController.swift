//
//  ConfirmAndPayController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class ConfirmAndPayController: UIViewController {
    
    let db = firebase.db

    @IBOutlet weak var applePayButton: UIButton!
//    @IBOutlet weak var invoiceID: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderBy: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var emailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        invoiceID.text = self.generateInvoiceID()
        orderBy.text = currentUserData.currentUser
        orderDate.text = invoiceData.orderDate
        orderTime.text = invoiceData.orderTime
        itemName.text = invoiceData.items[0]
        itemPrice.text = "$\(invoiceData.itemPrices[0])"
        itemQty.text = "\(invoiceData.itemQty[0])x\(Double(invoiceData.itemQty[0]) * invoiceData.itemPrices[0])"
        totalPrice.text = "$\(invoiceData.totalPrice)"
        
        let dismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboard)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func randomString() -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<4).map{ _ in letters.randomElement()! })
    }
    
    func paymentID() -> String {
        let id = "\(randomString())-\(randomString())-\(randomString())-\(randomString())"
        return id
    }
    
    func getTimeAndDate(type: String) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = type == "paidDate" ? "yyyy-MM-dd" : "HH:mm:ss"
        
        let result = format.string(from: date)
        
        return "\(result)"
    }
    
    func saveOrderData() {
        db.document("orders/\(invoiceData.invoiceNumber)").setData([
            "orderBy": currentUserData.currentUser,
            "date": invoiceData.orderDate,
            "time": invoiceData.orderTime,
            "itemName": invoiceData.items[0],
            "itemPrice": invoiceData.itemPrices[0],
            "itemQty": invoiceData.itemQty[0],
            "totalPrice": invoiceData.totalPrice,
            "emailAddress": emailAddress.text ?? "_nil",
            "paymentID": orderPayment.paymentID,
            "paidDate": orderPayment.paidDate,
            "paidTime": orderPayment.paidTime,
            "paymentMethod": orderPayment.paymentMethod,
            "paymentStatus": orderPayment.paymentStatus,
            "frontView": orderImages.frontView,
            "backView": orderImages.backView,
            "topView": orderImages.topView
        ])
    }
    
    @IBAction func payButton(_ sender: Any) {
        invoiceData.emailAddress = emailAddress.text ?? ""
        
        orderPayment.paymentID = paymentID()
        orderPayment.paidDate = getTimeAndDate(type: "paidDate")
        orderPayment.paidTime = getTimeAndDate(type: "paidTime")
        orderPayment.paymentMethod = "ApplePay"
        orderPayment.paymentStatus = true
        
        orderPayment.paymentStatus ? saveOrderData() : print("paymentStatus: false")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (applePayButton.frame.origin.y + applePayButton.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
        }
    }

    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
