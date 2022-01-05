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
    static var items = [String]();
    static var itemQty = [Int]();
    static var itemPrices = [Double]();
    static var totalPrice: Double = 0.00;
    static var emailAddress: String = "";
    static var pickupAddress: String = "";
    static var contactNumber: String = "";
}

struct orderImages {
    static var frontView: String = "";
    static var backView: String = "";
    static var topView: String = "";
}

struct orderPayment {
    static var paymentMethod: String = "";
    static var paidDate: String = "";
    static var paidTime: String = "";
    static var paymentID: String = "";
    static var paymentStatus: Bool = false;
}

struct shippingInfo {
    static var firstName: String = "";
    static var lastName: String = "";
    static var address: String = "";
    static var residential: String = "";
    static var city: String = "";
    static var country: String = "Hong Kong";
    static var zipCode: String = "";
}
