//
//  WorkshopReservationSearchViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import UIKit

class WorkshopReservationSearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchDecoIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.delegate = self
        
        searchDecoIcon.alpha = 0.1
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
