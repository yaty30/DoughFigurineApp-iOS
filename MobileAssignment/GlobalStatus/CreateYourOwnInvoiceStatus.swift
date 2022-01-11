//
//  CreateYourOwnInvoiceStatus.swift
//  MobileAssignment
//
//  Created by James Yip on 4/1/2022.
//

import Foundation
import UIKit

struct invoiceData {
    static var invoiceNumber: String = "";
    static var orderBy: String = "";
    static var orderDate: String = "";
    static var orderTime: String = "";
    static var orderDay: String = "";
    static var orderMonth: String = "";
    static var orderYear: String = "";
    static var items = [String]();
    static var itemQty = [String]();
    static var itemPrices = [Double]();
    static var totalPrice: Double = 0.00;
    static var emailAddress: String = "";
    static var pickupAddress: String = "";
    static var contactNumber: String = "";
}

struct orderImages {
    static var frontView: AnyObject = "" as AnyObject;
    static var backView: AnyObject = "" as AnyObject;
    static var topView: AnyObject = "" as AnyObject;
}

struct orderPayment {
    static var paymentMethod: String = "Credit card (Visa)";
    static var paidDate: String = "";
    static var paidTime: String = "";
    static var paymentID: String = "";
    static var paidAmount: Double = 0.00;
    static var paymentStatus: Bool = false;
}

struct shippingInfo {
    static var firstName: String = "";
    static var lastName: String = "";
    static var flat: String = "";
    static var floor: String = "";
    static var tower: String = "";
    static var residential: String = "";
    static var streetName: String = "";
    static var county: String = "";
    static var district: String = "";
    static var city: String = "";
    static var country: String = "Hong Kong";
    static var zipCode: String = "";
}
