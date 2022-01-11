//
//  generalFunc.swift
//  MobileAssignment
//
//  Created by James Yip on 7/1/2022.
//

import Foundation
import UIKit

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

public func getTimeAndDate(type: String) -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = type == "date" ? "yyyy-MM-dd" : "HH:mm:ss"
    
    let result = format.string(from: date)
    
    return "\(result)"
}
