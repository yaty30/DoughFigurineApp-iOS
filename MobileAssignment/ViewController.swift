//
//  ViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 1/1/2022.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var imageSlideShow: UIImageView!
    @IBOutlet weak var imageSlidePageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    @IBOutlet weak var verticalScrollView: UIScrollView!
    
    func setVerticalScrollIndicator(status: Bool) {
    }
}

