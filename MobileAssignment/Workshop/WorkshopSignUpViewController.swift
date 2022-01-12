//
//  WorkshopSignUpViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import UIKit

class WorkshopSignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    let db = firebase.db
    
    @IBOutlet weak var workshopTItle: UILabel!
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var timeslot: UIPickerView!
    @IBOutlet weak var pax: UITextField!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workshopContent.timeslot.count
    }
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workshopContent.timeslot[row]
    }
      
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        workshopSignup.timeslot = workshopContent.timeslot[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workshopSignup.workshopSignupID = "WS\(randomNumbers())"

        let dismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboard)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        timeslot.delegate = self
        timeslot.dataSource = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.view.frame.origin.y -= self.view.frame.origin.y < 0 ? 0 : 120
        }
    }

    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    func signupWorkshop() {
        
        db.document("workshopSignup/\(workshopSignup.workshopSignupID)").setData([
            "workshop": "Workshop: Mini Dough Warrior",
            "firstname": firstname.text ?? "",
            "lastname": lastname.text ?? "",
            "emailAddress": emailAddress.text ?? "",
            "contactNumber": tel.text ?? "",
            "pax": pax.text ?? "",
            "selectedTimesplot": workshopSignup.timeslot,
            "signupDate": getTimeAndDate(type: "date"),
            "signupTime": getTimeAndDate(type: "time"),
            "venue": "Xiqu Centre, 88 Austin Road West",
            "address": "88 Austin Road West, Tsim Sha Tsiu",
            "ticketFee": 250,
        ])
    }
    
    @IBAction func sigup(_ sender: Any) {
        signupWorkshop()
    }
}
