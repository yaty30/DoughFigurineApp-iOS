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
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var county: UITextField!
    @IBOutlet weak var district: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    
    @IBOutlet weak var mainview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.bringSubviewToFront(mainview)
        
        updateOrderInfo(updated: {})
        updateShippingInfo(updated: {})
        
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
            "city": shippingInfo.city,
            "country": shippingInfo.country,
            "zipCode": shippingInfo.zipCode,
            "contactNumber": invoiceData.contactNumber
        ])
        
        db.document("payment/\(invoiceData.invoiceNumber)").setData([
            "paymentID": self.paymentID(),
            "paidDate": orderPayment.paidDate,
            "paidTime": orderPayment.paidTime,
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
            self.updateShippingInfo(updated: {
                self.udpatePaymentInfo(updated: {
                    self.saveOrderData()
                })
            })
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
    
    func updateShippingInfo(updated: @escaping () -> Void) {
        DispatchQueue.main.async {
            shippingInfo.firstName = self.firstName.text ?? "_"
            shippingInfo.lastName = self.lastName.text ?? "_"
            shippingInfo.flat = self.flat.text ?? "_"
            shippingInfo.floor = self.floor.text ?? "_"
            shippingInfo.tower = self.tower.text ?? "_"
            shippingInfo.residential = self.residential.text ?? "_"
            shippingInfo.streetName = self.streetName.text ?? "_"
            shippingInfo.county = self.county.text ?? "_"
            shippingInfo.district = self.district.text ?? "_"
            shippingInfo.city = self.city.text ?? "_"
            shippingInfo.zipCode = self.zipCode.text ?? "_"
            invoiceData.contactNumber = self.contactNumber.text ?? "_"
            
            updated()
        }
    }
    
    func udpatePaymentInfo(updated: @escaping () -> Void) {
        DispatchQueue.main.async {
            orderPayment.paidAmount = 399.00
            orderPayment.paidDate = getTimeAndDate(type: "date")
            orderPayment.paidTime = getTimeAndDate(type: "time")
            
            updated()
        }
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
    
    @IBAction func cancelOrderTrigger(_ sender: Any) {
        self.cancelOrder()
    }
    
    func cancelOrder() {
        let actionSheet = UIAlertController(title: title, message: "Are you sure you want to CANCEL the order?", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! ViewController
            
            nextVC.modalPresentationStyle = .fullScreen
            self!.present(nextVC, animated:true, completion:nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: { [] _ in
            print("dismissed")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        
        
        present(actionSheet, animated: true)
    }
}
