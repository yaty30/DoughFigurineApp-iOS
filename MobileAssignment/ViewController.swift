//
//  ViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 1/1/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var articleTag: Int = -1;
    var coordinates: CLLocationCoordinate2D? = nil
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var imageSlideShow: UIImageView!
    @IBOutlet weak var imageSlidePageControl: UIPageControl!
    
    @IBOutlet weak var smArticleOne: UIButton!
    @IBOutlet weak var smArticleTwo: UIButton!
    @IBOutlet weak var lgArticleTwo: UIButton!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest(apiURL: "https://61dff0d40f3bdb0017934c78.mockapi.io/v1/recordRunTime")
        
        date.text = "2022"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            updateLocation(location, updated: {
                self.saveLog()
            })
        }
    }

    var currentImage = 1
    @IBAction func nextImage(_ sender: Any) {
        if(currentImage > 3) {
            self.currentImage = 1
        } else {
            self.currentImage += 1
        }
        self.imageSlidePageControl.currentPage = currentImage - 1
        
        let imageToShow = "slide_image_\(currentImage)"
        imageSlideShow.image = UIImage(named: imageToShow)
    }
    
    @IBAction func previousImage(_ sender: Any) {
        if(currentImage < 2) {
            self.currentImage = 4
        } else {
            self.currentImage -= 1
        }
        self.imageSlidePageControl.currentPage = currentImage - 1
        
        let imageToShow = "slide_image_\(currentImage)"
        imageSlideShow.image = UIImage(named: imageToShow)
    }
    
    @IBAction func smallArticle(_ sender: Any) {
        selectedArticle.title = "Dough Sculpture"
        selectedArticle.tag = 0
        selectedArticle.doc = "ElementsofIntangibleCulturalHeritage"
    }
    
   
    @IBAction func lgArticle(_ sender: Any) {
        selectedArticle.title = "Enchanting Dough Figurines"
        selectedArticle.tag = 1
        selectedArticle.doc = "EnchantingDoughFigurines"
    }
    
    @IBOutlet weak var verticalScrollView: UIScrollView!
    
    func saveLog() {
        let targetAPI = "https://61dff0d40f3bdb0017934c78.mockapi.io/v1/recordRunTime"
        
        let body: [String:AnyHashable] = [
            "logDate": getTimeAndDate(type: "date"),
            "logTime": getTimeAndDate(type: "time"),
            "logToken": getToken(),
            "logCount": logRecord.logCount + 1,
            "coordinates": [
                "latitude": coordinates?.latitude,
                "longitude": coordinates?.longitude
            ]
        ]
        
        postRequest(apiURL: targetAPI, body: body)
    }
    
    func updateLocation(_ location: CLLocation, updated: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.coordinates = location.coordinate
            
            if(self.coordinates != nil) {
                updated()
            } else {
                print("save log failed.")
                updated()
            }
        }
    }
    
    
    
    
}
