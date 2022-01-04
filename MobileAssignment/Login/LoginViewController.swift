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
    
    let db = firebase.db
    
    func login(data: [String: Any]) {
        let docRef = db.document("user/loginData")
        docRef.setData(data)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getTimeAndDate(type: String) -> String {
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
    
    func generateToken() -> String {
        let date = Date()
        let format = DateFormatter()
        
        format.dateFormat = "yyyyMMddHHmmss"
        
        let token = format.string(from: date)
        let addon = self.randomString(length: 5)
        
        return "\(token)\(addon)"
    }
    
    @IBAction func loginButton(_ sender: Any) {
        login(data: ["username": usernameField.text ?? "username_nil"])
        login(data: ["date": getTimeAndDate(type: "orderDate")])
        login(data: ["time": getTimeAndDate(type: "orderTime")])
        login(data: ["token": generateToken()])
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
