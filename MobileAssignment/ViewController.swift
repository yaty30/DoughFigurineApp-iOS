//
//  ViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 1/1/2022.
//

import UIKit

class ViewController: UIViewController{
    
    var articleTag: Int = -1;
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var imageSlideShow: UIImageView!
    @IBOutlet weak var imageSlidePageControl: UIPageControl!
    
    @IBOutlet weak var smArticleOne: UIButton!
    @IBOutlet weak var smArticleTwo: UIButton!
    @IBOutlet weak var lgArticleTwo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date.text = "2022"
        
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
    
    func setVerticalScrollIndicator(status: Bool) {
    }
}



