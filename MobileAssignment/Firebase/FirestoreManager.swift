//
//  FirestoreManager.swift
//  MobileAssignment
//
//  Created by James Yip on 6/1/2022.
//

import Foundation
import FirebaseFirestore
import Firebase

final class StorageManager {
    static let shared = StorageManager()
    
    let storage = Storage.storage().reference()
    
    public typealias UploadImageCompletion = (Result<String, Error>) -> Void
    public func uploadOrderImages(with data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("orderImages/#\(fileName)").putData(data, metadata: nil, completion: { metatdata, error in
            guard error == nil else {
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("orderImages/#\(fileName)").downloadURL(completion: { url, err in
                guard let url = url else {
                    completion(.failure(StorageErrors.failedToDownloadImage))
                    return
                }
                let urlString = url.absoluteString
                print("downloading from url... ")
                completion(.success(urlString ))
            })
            
        })
    }

    public enum StorageErrors: Error {
        case failedToUpload
        case failedToDownloadImage
    }
    
}
