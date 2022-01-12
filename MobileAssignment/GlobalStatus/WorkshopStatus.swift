//
//  WorkshopStatus.swift
//  MobileAssignment
//
//  Created by James Yip on 12/1/2022.
//

import Foundation

struct workshopContent {
    static var date: String = ""
    static var workshopTitle: String = ""
    static var coverImage: String = ""
    static var overviewOne: String = ""
    static var overviewTwo: String = ""
    static var overviewThree: String = ""
    static var workshopDate: String = ""
    static var workshopTimeOne: String = ""
    static var workshopTimeTwo: String = ""
    static var approximatelyHours: String = ""
    static var venue: String = ""
    static var ticketFee: String = ""
    static var ticketFeeCaption: String = ""
    static var ticketDescriptionOne: String = ""
    static var ticketDescriptionTwo: String = ""
    static var timeslot = [String]()
}

struct workshopSignup {
    static var workshop: String = ""
    static var firstname: String = ""
    static var lastname: String = ""
    static var tel: String = ""
    static var emailAddress: String = ""
    static var timeslot: String = "10:00 am" // default value of picker
    static var pax: String = ""
    static var workshopSignupID: String = ""
}

struct workshopResevationSearch {
    static var id: String = ""
}
