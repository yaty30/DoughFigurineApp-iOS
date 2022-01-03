//
//  PreviewCreateYourOwnPhotosController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class PreviewCreateYourOwnPhotosController: UIViewController,  UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var frontViewImage: UIImageView!
    @IBOutlet weak var backViewImage: UIImageView!
    @IBOutlet weak var topViewImage: UIImageView!
    
    @IBOutlet weak var frontViewRetake: UIButton!
    @IBOutlet weak var backViewRetake: UIButton!
    @IBOutlet weak var topViewRetake: UIButton!
    var imageList = [Any]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontViewImage.image = imageList[0] as? UIImage
        backViewImage.image = imageList[1] as? UIImage
        topViewImage.image = imageList[2] as? UIImage

        frontViewRetake?.tag = 0
        backViewRetake?.tag = 1
        topViewRetake?.tag = 2
        
    }
    
    var currentButtonIndex: Int = -1;
    
    @IBAction func retakeImage(_ sender: Any) {
        currentButtonIndex = (sender as AnyObject).tag
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        print("...")
        present(picker, animated: true )
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        if(currentButtonIndex == 0) {
            frontViewImage.image = image
        } else if(currentButtonIndex == 1) {
            backViewImage.image = image
        } else if(currentButtonIndex == 2) {
            topViewImage.image = image
        } else { print("Incorrect button index") }
        
    }
}
