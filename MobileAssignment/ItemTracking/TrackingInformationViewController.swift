//
//  TrackingInformationViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 11/1/2022.
//

import UIKit

class TrackingInformationViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Where To?"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        view.addSubview(label)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
    }

}
