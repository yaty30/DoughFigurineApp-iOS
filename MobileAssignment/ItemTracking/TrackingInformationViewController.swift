//
//  TrackingInformationViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 11/1/2022.
//

import UIKit
import CoreLocation

class TrackingInformationViewController: UIViewController {
    private let invoiceNumber: UILabel = {
        let invoiceNo = UILabel()
        invoiceNo.text = "Invoice #\(findYourOrder.targetInvoiceNumber)"
        invoiceNo.font = .systemFont(ofSize: 20, weight: .semibold)
        return invoiceNo
    }()

    private let estimatedArrivalDate: UILabel = {
        let date = UILabel()
        date.text = getEstimatedArrival(invoiceTracking.deliverPoint, invoiceTracking.destinationPoint!)
        
        date.font = .systemFont(ofSize: 30, weight: .bold)
        return date
    }()
    
    private let estimatedArrivalText: UILabel = {
        let invoiceNo = UILabel()
        invoiceNo.text = "Estimated arrival"
        invoiceNo.font = .systemFont(ofSize: 17, weight: .regular)
        return invoiceNo
    }()
    
    // Deliver from
    func deliverWithinIcon() -> UIImageView {
        let icon = UIImageView()
        icon.image = UIImage(named: "estimated_arrival_date_icon", in: Bundle(for: type(of: self)), compatibleWith: nil)
        
        return icon
    }
    
    private let deliverWithinDate: UILabel = {
        let label = UILabel()
        label.text = getDeliverWithin(invoiceTracking.deliverPoint,
                                      invoiceTracking.destinationPoint!)
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private let deliverWithinText: UILabel = {
        let label = UILabel()
        label.text = "Deliver within"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    // Intersaction Station
    private let intersactionData: UILabel = {
        let label = UILabel()
        label.text = "KTShipping Station"
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private let intersactionText: UILabel = {
        let label = UILabel()
        label.text = "Intersaction Station"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    // Shipping Destination
    private let destinationData: UILabel = {
        let label = UILabel()
        label.text = "address...."
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private let destinationText: UILabel = {
        let label = UILabel()
        label.text = "Your Deliver Address"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    // Distance from devliver
    private let distanceData: UILabel = {
        let km = getDistanceInKM(invoiceTracking.deliverPoint,
                                 invoiceTracking.destinationPoint!)
        let label = UILabel()
        label.text = "~\(km) KM"
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private let distanceText: UILabel = {
        let label = UILabel()
        label.text = "Distance from deliver"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(invoiceNumber)
        view.addSubview(estimatedArrivalDate)
        view.addSubview(estimatedArrivalText)
        view.addSubview(deliverWithinDate)
        view.addSubview(deliverWithinText)
        view.addSubview(deliverWithinIcon())
        
        view.addSubview(intersactionData)
        view.addSubview(intersactionText)
        
        view.addSubview(distanceData)
        view.addSubview(distanceText)
        
        view.addSubview(destinationData)
        view.addSubview(destinationText)

        // Do any additional setup after loading the view.
    }
    
    let iconX: CGFloat = 50
    let sectionX: CGFloat = 90
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        invoiceNumber.sizeToFit()
        invoiceNumber.frame = CGRect(x: 30, y: 40, width: invoiceNumber.frame.size.width, height: invoiceNumber.frame.size.height)
        
        
        
        estimatedArrivalDate.sizeToFit()
        estimatedArrivalDate.frame = CGRect(x: 30, y: 100, width: estimatedArrivalDate.frame.size.width, height: estimatedArrivalDate.frame.size.height)
        
        estimatedArrivalText.sizeToFit()
        estimatedArrivalText.frame = CGRect(x: 265, y: 115, width: estimatedArrivalText.frame.size.width, height: estimatedArrivalText.frame.size.height)
        
        
        
        deliverWithinIcon().sizeToFit()
        deliverWithinIcon().frame = CGRect(x: 30, y: 160, width: deliverWithinIcon().frame.size.width, height: deliverWithinIcon().frame.size.height)
        
        deliverWithinText.sizeToFit()
        deliverWithinText.frame = CGRect(x: sectionX, y: 180, width: deliverWithinText.frame.size.width, height: deliverWithinText.frame.size.height)
        
        deliverWithinDate.sizeToFit()
        deliverWithinDate.frame = CGRect(x: sectionX, y: 210, width: deliverWithinDate.frame.size.width, height: deliverWithinDate.frame.size.height)
        
        
        
        intersactionText.sizeToFit()
        intersactionText.frame = CGRect(x: sectionX, y: 290, width: intersactionText.frame.size.width, height: intersactionText.frame.size.height)
        
        intersactionData.sizeToFit()
        intersactionData.frame = CGRect(x: sectionX, y: 320, width: intersactionData.frame.size.width, height: intersactionData.frame.size.height)
        
        
        
        distanceText.sizeToFit()
        distanceText.frame = CGRect(x: sectionX, y: 400, width: distanceText.frame.size.width, height: distanceText.frame.size.height)
        
        distanceData.sizeToFit()
        distanceData.frame = CGRect(x: sectionX, y: 430, width: distanceData.frame.size.width, height: distanceData.frame.size.height)
        
        
        
        destinationText.sizeToFit()
        destinationText.frame = CGRect(x: sectionX, y: 510, width: destinationText.frame.size.width, height: destinationText.frame.size.height)
        
        destinationData.sizeToFit()
        destinationData.frame = CGRect(x: sectionX, y: 540, width: destinationData.frame.size.width, height: destinationData.frame.size.height)
        
    }

}
