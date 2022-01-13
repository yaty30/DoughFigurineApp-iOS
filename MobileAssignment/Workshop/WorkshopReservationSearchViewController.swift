//
//  WorkshopReservationSearchViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import UIKit

class WorkshopReservationSearchViewController: UIViewController, UITextFieldDelegate{

    var lastOrderNumber = [LastOrderWorkshopItem]()
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchDecoIcon: UIImageView!
    @IBOutlet weak var previousID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.previousID.text = ""
        searchDecoIcon.alpha = 0.1
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        getLastOrderNumber()
    }
    
    func getLastOrderNumber() {
        do {
            lastOrderNumber = try context!.fetch(LastOrderWorkshopItem.fetchRequest()) as! [LastOrderWorkshopItem]
            
            var index = lastOrderNumber.count - 1
            index = index < 0 ? 0 : index
            let result = self.lastOrderNumber[index].workshopReservationID

            DispatchQueue.main.async {
                self.previousID.text = "Last reservation ID: \(result as! String)"
            }
        } catch {
            // error
        }
    }
    
    @IBAction func searchBarDidChanged(_ sender: Any) {
        if let searchBarText = input.text {
            if(searchBarText.count > 0) {
                workshopResevationSearch.id = "WS\(input?.text ?? "")"
            } else { return }
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        workshopResevationSearch.id = "WS\(input?.text ?? "")"
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
