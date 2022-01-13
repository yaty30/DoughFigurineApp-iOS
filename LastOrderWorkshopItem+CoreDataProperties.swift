//
//  LastOrderWorkshopItem+CoreDataProperties.swift
//  MobileAssignment
//
//  Created by James Yip on 13/1/2022.
//
//

import Foundation
import CoreData


extension LastOrderWorkshopItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastOrderWorkshopItem> {
        return NSFetchRequest<LastOrderWorkshopItem>(entityName: "LastOrderWorkshopItem")
    }

    @NSManaged public var workshopReservationID: String?
    @NSManaged public var customYourOwnOrderID: String?

}

extension LastOrderWorkshopItem : Identifiable {

}
