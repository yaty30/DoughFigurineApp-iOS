//
//  ItemTrackingViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 5/1/2022.
//

import UIKit
class ItemTrackingViewController: UIViewController, UITextFieldDelegate {

    let db = firebase.db
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var lastOrderNumber = [LastOrderWorkshopItem]()
    
    @IBOutlet weak var searchBarIconView: UIView!
    @IBOutlet weak var invoiceSearchBar: UITextField!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var lastOrderNumberFromCore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLastOrderNumber()
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

    func getLastOrderNumber() {
        do {
            lastOrderNumber = try context!.fetch(LastOrderWorkshopItem.fetchRequest()) as! [LastOrderWorkshopItem]
            
            var index = lastOrderNumber.count - 1
            index = index < 0 ? 0 : index
            
            DispatchQueue.main.async {
                let result = self.lastOrderNumber[index].customYourOwnOrderID
                self.lastOrderNumberFromCore.text = result == nil ? "" : "Last order: \(result as! String)"
            }
        } catch {
            // error
        }
    }

    func updateLastOrderNumber(item: LastOrderWorkshopItem, newID: String, type: String) {
        if(type == "order") {
            item.customYourOwnOrderID = newID
        } else {
            item.workshopReservationID = newID
        }
        
        do {
            try context?.save()
        } catch {
            // error
        }
    }


    
}
