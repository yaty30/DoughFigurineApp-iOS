//
//  ItemTracking.swift
//  MobileAssignment
//
//  Created by James Yip on 6/1/2022.
//

import Foundation
import CoreLocation

struct findYourOrder {
    static var targetInvoiceNumber: String = ""
}

struct invoiceTracking {
    static var deliverStreet: String = ""
    static var deliverCountry: String = ""
    static var deliverAddress: String = ""
    static var deliverResidential: String = ""
    static var orderDate: String = ""
    static var orderDay: Int = 0
    static var orderMonth: Int = 0
    static var deliverCoordinate: CLLocationCoordinate2D? = nil
}
