//
//  FinalInvoiceViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 4/1/2022.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

class FinalInvoiceViewController: UIViewController {
    
    let db = firebase.db
    
    @IBOutlet weak var previewMap: MKMapView!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var flatAndTower: UILabel!
    @IBOutlet weak var streetName: UILabel!
    @IBOutlet weak var countyAndDistrict: UILabel!
    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var paidAmount: UILabel!
    @IBOutlet weak var paidOn: UILabel!
    @IBOutlet weak var paidAt: UILabel!
    
    @IBOutlet weak var outterLoadingView: UIView!
    @IBOutlet weak var outterLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outterLoading.startAnimating()

        getInvoiceInfo()
        getPaymentInfo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1...1.6)) {
            
            self.getShippingInfo()
            
            self.outterLoadingView.isHidden = true
            self.loadingView.isHidden = true
            self.mapCreate(done: {})
        }
    }
    
    func getInvoiceInfo() {
        invoiceNumber.text = "Invoice \(invoiceData.invoiceNumber)"
        orderDate.text = invoiceData.orderDate
        orderTime.text = "at \(invoiceData.orderTime)"
        itemName.text = invoiceData.items[0]
        itemQty.text = invoiceData.itemQty[0]
        itemPrice.text = "$\(invoiceData.itemPrices[0])"
        totalPrice.text = "$\(invoiceData.totalPrice)"
    }
    
    func getShippingInfo() {
        name.text = "\(shippingInfo.firstName) \(shippingInfo.lastName)"
        emailAddress.text = invoiceData.emailAddress
        contactNumber.text = invoiceData.contactNumber
        
        let towerIsNil = shippingInfo.tower == "" ? "" : ", Tower \(shippingInfo.tower)"
        flatAndTower.text = "Flat \(shippingInfo.floor)\(shippingInfo.flat)\(towerIsNil), \(shippingInfo.residential)"
        
        streetName.text = shippingInfo.streetName
        
        countyAndDistrict.text = "\(shippingInfo.county), \(shippingInfo.district)"
        
        cityAndCountry.text = "\(shippingInfo.city), \(shippingInfo.country)"
        
        zipCode.text = shippingInfo.zipCode
    }
    
    func getPaymentInfo() {
        paymentMethod.text = orderPayment.paymentMethod
        paidAmount.text = "$\(orderPayment.paidAmount)"
        paidOn.text = invoiceData.orderDate
        paidAt.text = invoiceData.orderTime
    }
    
    func mapCreate(done: @escaping () -> Void) {
        previewMap.removeAnnotations(previewMap.annotations)
        LocationManager.shared.findLocation(with: shippingInfo.streetName) { [weak self] locations in
            DispatchQueue.main.async {
                let pin = MKPointAnnotation()
                pin.coordinate = locations[0].Coordinates!
                pin.title = "Shipping Address"
                self!.previewMap.addAnnotation(pin)
                
                let region = MKCoordinateRegion(center: locations[0].Coordinates!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self!.previewMap.setRegion(region, animated: true)
                
                invoiceTracking.destinationPoint = CLLocation(latitude: locations[0].Coordinates!.latitude, longitude: locations[0].Coordinates!.longitude)
                
                done()
            }
        }
    }

}
