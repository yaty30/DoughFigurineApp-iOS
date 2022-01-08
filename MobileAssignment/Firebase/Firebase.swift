//
//  Firebase.swift
//  MobileAssignment
//
//  Created by James Yip on 5/1/2022.
//

import FirebaseFirestore
import Firebase
import Foundation

struct firebase {
    static let db = Firestore.firestore()
    static let ref = Storage.storage().reference()
}
