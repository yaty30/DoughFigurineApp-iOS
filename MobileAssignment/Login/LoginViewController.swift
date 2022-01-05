//
//  LoginViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 4/1/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        let docRef = db.document("user/loginData")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print(data)
        }
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getTimeAndDate(type: String) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = type == "loginDate" ? "yyyy-MM-dd" : "HH:mm:ss"
        
        let result = format.string(from: date)
        
        return "\(result)"
    }
    
    func generateToken() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<25).map{ _ in letters.randomElement()! })
    }
    
    let db = firebase.db
    
    @IBAction func loginButton(_ sender: Any) {
//        login(data: ["username": usernameField.text ?? "username_nil"])
//        login(data: ["date": getTimeAndDate(type: "orderDate")])
//        login(data: ["time": getTimeAndDate(type: "orderTime")])
        
        let token = generateToken()
        
        db.document("login/\(token)").setData([
            "username": usernameField.text ?? "username_nil",
            "date": getTimeAndDate(type: "loginDate"),
            "time": getTimeAndDate(type: "loginTime")
        ])
        
        currentUserData.currentUser = usernameField.text ?? ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
