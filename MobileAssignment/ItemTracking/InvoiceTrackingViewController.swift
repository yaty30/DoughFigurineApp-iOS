//
//  InvoiceTrackingViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 6/1/2022.
//

import UIKit

class InvoiceTrackingViewController: UIViewController {

    @IBOutlet weak var informationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bringSubviewToFront(informationView)
    }
    

    @IBAction func dismissCurrentView(_ sender: Any) {

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
