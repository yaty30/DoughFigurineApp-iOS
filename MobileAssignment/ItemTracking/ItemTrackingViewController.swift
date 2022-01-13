//
//  ItemTrackingViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 5/1/2022.
//

import UIKit

class ItemTrackingViewController: UIViewController, UITextFieldDelegate {

    let db = firebase.db
    
    @IBOutlet weak var searchBarIconView: UIView!
    @IBOutlet weak var invoiceSearchBar: UITextField!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var lastOrderNumberFromCore: UILabel!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarIconView?.alpha = 0.1
        searchIcon?.alpha = 0.1
        searchButton?.isEnabled = false
        
        self.invoiceSearchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        lastOrderNumberFromCore.text = ""
    }
    
    @IBAction func searchBarDidChanged(_ sender: Any) {
        if let searchBarText = invoiceSearchBar.text {
            if(searchBarText.count > 0) {
                searchIcon?.alpha = 1
                searchButton?.isEnabled = true
                findYourOrder.targetInvoiceNumber = invoiceSearchBar?.text ?? ""
            } else {
                searchIcon?.alpha = 0.1
                searchButton?.isEnabled = false
            }
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        findYourOrder.targetInvoiceNumber = invoiceSearchBar?.text ?? ""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
