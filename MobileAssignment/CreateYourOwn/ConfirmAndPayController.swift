//
//  ConfirmAndPayController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class ConfirmAndPayController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // Gmail API Key = AIzaSyBiiz6ttTRM7XN4YUhcK4M4-Q53Cha3ZZo
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
    @IBOutlet weak var countryPicker: UIPickerView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var residential: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateOrderInfo()
        updateShippingInfo()
        
        let dismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboard)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        view.bringSubviewToFront(countryPicker)
    }
    
    func paymentID() -> String {
        let id = "\(randomString())-\(randomString())-\(randomString())-\(randomString())"
        return id
    }
    
    func saveOrderData() {
        db.document("orders/\(invoiceData.invoiceNumber)").setData([
            "orderBy": currentUserData.currentUser,
            "date": invoiceData.orderDate,
            "day": Int(invoiceData.orderDay)!,
            "month": Int(invoiceData.orderMonth)!,
            "year": Int(invoiceData.orderYear)!,
            "time": invoiceData.orderTime,
            "itemName": invoiceData.items[0],
            "itemPrice": invoiceData.itemPrices[0],
            "itemQty": invoiceData.itemQty[0],
            "totalPrice": invoiceData.totalPrice,
            "emailAddress": emailAddress.text ?? "_nil",
        ])
        
        db.document("shipping/\(invoiceData.invoiceNumber)").setData([
            "firstName": shippingInfo.firstName,
            "lastName": shippingInfo.lastName,
            "address": shippingInfo.address,
            "residential": shippingInfo.residential,
            "country": shippingInfo.country,
            "zipCode": shippingInfo.zipCode
        ])
        
        db.document("payment/\(invoiceData.invoiceNumber)").setData([
            "paymentID": orderPayment.paymentID,
            "paidDate": orderPayment.paidDate,
            "paidTime": orderPayment.paidTime,
            "paymentMethod": orderPayment.paymentMethod,
            "paymentStatus": orderPayment.paymentStatus
        ])
    
        db.document("orderImages/\(invoiceData.invoiceNumber)").setData([
            "frontView": orderImages.frontView,
            "backView": orderImages.backView,
            "topView": orderImages.topView
        ])
    }
    
    @IBAction func payButton(_ sender: Any) {
        invoiceData.emailAddress = emailAddress.text ?? ""
        updateOrderInfo()
        updateShippingInfo()
        saveOrderData()
    }
    
    func updateOrderInfo() {
        // invoiceID.text = self.generateInvoiceID()
        orderBy.text = currentUserData.currentUser
        orderDate.text = invoiceData.orderDate
        orderTime.text = invoiceData.orderTime
        itemName.text = invoiceData.items[0]
        itemPrice.text = "$\(invoiceData.itemPrices[0])"
        itemQty.text = "\(invoiceData.itemQty[0])x\(Double(invoiceData.itemQty[0])! * invoiceData.itemPrices[0])"
        totalPrice.text = "$\(invoiceData.totalPrice)"
    }
    
    func updateShippingInfo() {
        shippingInfo.firstName = firstName.text ?? ""
        shippingInfo.lastName = lastName.text ?? ""
        shippingInfo.address = address.text ?? ""
        shippingInfo.residential = residential.text ?? ""
        shippingInfo.zipCode = zipCode.text ?? ""
        shippingInfo.city = city.text ?? ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.firstName = textField
        self.lastName = textField
        self.address = textField
        self.residential = textField
        self.city = textField
        self.zipCode = textField
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.firstName.enablesReturnKeyAutomatically
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            // let bottomSpace = (self.view.frame.height + 491) - (applePayButton.frame.origin.y + applePayButton.frame.height)
            self.view.frame.origin.y -= keyboardFrame.cgRectValue.height
        }
    }

    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return usefulData.countryList.count
    }
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return usefulData.countryList[row]
    }
      
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shippingInfo.country = usefulData.countryList[row]
    }
}
