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
    var isEmailEditing = false

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
    
    @IBOutlet weak var flat: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var tower: UITextField!
    @IBOutlet weak var residential: UITextField!
    @IBOutlet weak var county: UITextField!
    @IBOutlet weak var district: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateOrderInfo(updated: {})
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
            "flat": shippingInfo.flat,
            "floor": shippingInfo.floor,
            "tower": shippingInfo.tower,
            "residential": shippingInfo.residential,
            "streetName": shippingInfo.streetName,
            "county": shippingInfo.county,
            "district": shippingInfo.district,
            "country": shippingInfo.country,
            "zipCode": shippingInfo.zipCode
        ])
        
        db.document("payment/\(invoiceData.invoiceNumber)").setData([
            "paymentID": self.paymentID(),
            "paidDate": getTimeAndDate(type: "date"),
            "paidTime": getTimeAndDate(type: "time"),
            "paymentMethod": orderPayment.paymentMethod,
            "paidAmount": orderPayment.paidAmount,
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
        updateOrderInfo(updated: {
            self.updateShippingInfo()
            self.saveOrderData()
        })
    }
    
    func updateOrderInfo(updated: @escaping () -> Void) {
        DispatchQueue.main.async {
            // invoiceID.text = self.generateInvoiceID()
            self.orderDate.text = invoiceData.orderDate
            self.orderTime.text = invoiceData.orderTime
            self.itemName.text = invoiceData.items[0]
            self.itemPrice.text = "$\(invoiceData.itemPrices[0])"
            self.itemQty.text = "\(invoiceData.itemQty[0])x\(Double(invoiceData.itemQty[0]) ?? 1 * invoiceData.itemPrices[0])"
            self.totalPrice.text = "$\(invoiceData.totalPrice)"
            
            updated()
        }
    }
    
    func updateShippingInfo() {
        shippingInfo.firstName = firstName.text ?? ""
        shippingInfo.lastName = lastName.text ?? ""
//        shippingInfo.address = address.text ?? ""
        shippingInfo.residential = residential.text ?? ""
        shippingInfo.zipCode = zipCode.text ?? ""
        shippingInfo.city = city.text ?? ""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.view.frame.origin.y -= self.view.frame.origin.y < 0 ? 0 : 310
//            print("type of ", type(of: self.view.frame.origin.y))
//            print(self.view.frame.origin.y)
//            print(self.view.frame.origin.y == -310.0)
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
