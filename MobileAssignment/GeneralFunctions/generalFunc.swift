//
//  generalFunc.swift
//  MobileAssignment
//
//  Created by James Yip on 7/1/2022.
//

import Foundation

public func getMonthName(_ month: String) -> String {
    let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN",
                  "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    let monthIndex = Int(month) ?? 1
    
    return months[monthIndex - 1]
}
