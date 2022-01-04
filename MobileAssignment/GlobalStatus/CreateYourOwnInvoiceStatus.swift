//
//  CreateYourOwnInvoiceStatus.swift
//  MobileAssignment
//
//  Created by James Yip on 4/1/2022.
//

import Foundation

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
