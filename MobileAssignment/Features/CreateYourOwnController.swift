//
//  CreateYourOwnController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class CreateYourOwnController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var frontViewBtn: UIButton!
    @IBOutlet weak var backViewBtn: UIButton!
    @IBOutlet weak var topViewBtn: UIButton!
    
    @IBOutlet weak var frontViewImage: UIImageView!
    @IBOutlet weak var backViewImage: UIImageView!
    @IBOutlet weak var topViewImage: UIImageView!

    @IBOutlet weak var firstStepView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        frontViewBtn?.tag = 0
        backViewBtn?.tag = 1
        topViewBtn?.tag = 2
        // Do any additional setup after loading the view.
    }
    
    var currentButtonIndex: Int = -1;
    
    @IBAction func getViewsImages(_ sender: Any) {
        currentButtonIndex = (sender as AnyObject).tag
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        if(currentButtonIndex == 0) {
            frontViewImage.image = image
        } else if(currentButtonIndex == 1) {
            backViewImage.image = image
        } else if(currentButtonIndex == 2) {
            topViewImage.image = image
        } else { print("Incorrect button index") }
        
    }
    
}
