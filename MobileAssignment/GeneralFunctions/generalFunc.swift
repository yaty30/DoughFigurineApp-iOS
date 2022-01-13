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

public func getToken() -> String {
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<12).map{ _ in letters.randomElement()! })
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

//

public func postRequest(apiURL: String, body: [String:AnyHashable]) {
    guard let url = URL(string: apiURL) else { return }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    // Request
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else { return }
        
        do {
            let res = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            print(error)
        }
    }
    task.resume()
}

public func getRequest(apiURL: String) {
    guard let url = URL(string: apiURL) else { return }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
  
    // Request
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else { return }
        
        do {
            let res = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(res)
        } catch {
            print(error)
        }
    }
    task.resume()
}

// Core Data
let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

func getLastOrderNumber() {
    do {
        let item = try context?.fetch(LastOrderWorkshopItem.fetchRequest())
        
    } catch {
        // error
    }
}

func updateLastOrderNumber(item: LastOrderWorkshopItem, newID: String, type: String) {
    if(type == "order") {
        item.customYourOwnOrderID = newID
    } else {
        item.workshopReservationID = newID
    }
    
    do {
        try context?.save()
    } catch {
        // error
    }
}



