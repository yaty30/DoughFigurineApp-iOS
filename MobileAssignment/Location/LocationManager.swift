//
//  LocationManager.swift
//  MobileAssignment
//
//  Created by James Yip on 11/1/2022.
//

import Foundation
import CoreLocation

struct Location {
    let title: String;
    let Coordinates: CLLocationCoordinate2D?;
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    public func findLocation(with query: String, completion: @escaping (([Location])) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places, error in
            guard let palces = places, error == nil else {
                completion([])
                return
            }
            
            let models: [Location] = places!.compactMap({ place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                if let locality = place.locality {
                    name += ", \(locality)"
                }
                
                print("\n\(place)\n\n")
                
                let result = Location(title: name,
                                      Coordinates: place.location?.coordinate)
                return result
            })
            completion(models)
        }
    }
}
