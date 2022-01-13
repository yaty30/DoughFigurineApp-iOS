//
//  generalFunc.swift
//  MobileAssignment
//
//  Created by James Yip on 7/1/2022.
//

import Foundation
import UIKit
import CoreLocation

public func getMonthName(_ month: Int) -> String {
    let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN",
                  "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    let monthIndex = month
    
    return months[monthIndex - 1]
}

public func randomString() -> String {
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    return String((0..<4).map{ _ in letters.randomElement()! })
}

public func randomNumbers() -> String {
    let alphas = "0123456789"
    return String((0..<4).map{ _ in alphas.randomElement()! })
}

public func getTimeAndDate(type: String) -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = type == "date" ? "yyyy-MM-dd" : "HH:mm:ss"
    
    let result = format.string(from: date)
    
    return "\(result)"
}


// Item Tracking

public func getDistanceInKM(_ deliverPoint: CLLocation, _ destination: CLLocation) -> Double {
    
    let distanceInKM = round((deliverPoint.distance(from: destination) / 1000) * 100) / 100.0
    
    return distanceInKM
}

public func getDeliverWithin(_ deliverPoint: CLLocation, _ destination: CLLocation) -> String {
    // 5.34 -> human walking km per 30 mins
    let days = Int(floor(getDistanceInKM(deliverPoint, destination) / 5.34))
    let res = days < 1 ? "< 1 day" : "~\(days) \(days > 1 ? "days" : "day")"
    
    return res
}

public func getEstimatedArrival(_ deliverPoint: CLLocation, _ destination: CLLocation) -> String {
    let days = Int(floor(getDistanceInKM(deliverPoint, destination) / 5.34))
    
    let estimatedDay = invoiceTracking.orderDay + days
    let estimatedMonth = getMonthName(invoiceTracking.orderMonth)
    
    let res = "\(estimatedDay) \(estimatedMonth)"
    
    return res
}
