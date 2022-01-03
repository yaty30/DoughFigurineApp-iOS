//
//  PreviewCreateYourOwnPhotosController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class PreviewCreateYourOwnPhotosController: UIViewController {

    
    @IBOutlet weak var frontViewImage: UIImageView!
    @IBOutlet weak var backViewImage: UIImageView!
    @IBOutlet weak var topViewImage: UIImageView!
    var imageList = [Any]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontViewImage.image = imageList[0] as? UIImage
        backViewImage.image = imageList[1] as? UIImage
        topViewImage.image = imageList[2] as? UIImage

        // Do any additional setup after loading the view.
    }
    


}
