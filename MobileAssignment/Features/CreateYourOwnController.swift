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
    @IBOutlet weak var firstStepView: UIView!
    
    @IBOutlet weak var frontViewStepIcon: UIImageView!
    @IBOutlet weak var backViewStepIcon: UIImageView!
    @IBOutlet weak var topViewStepIcon: UIImageView!
    
    @IBOutlet weak var backViewButtonIcon: UIImageView!
    @IBOutlet weak var topViewButtonIcon: UIImageView!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var previousPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontViewBtn?.tag = 0
        backViewBtn?.tag = 1
        topViewBtn?.tag = 2
        
        backViewBtn.isEnabled = false
        backViewButtonIcon.alpha = 0.2
        
        topViewBtn.isEnabled = false
        topViewButtonIcon.alpha = 0.2
        
        continueButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    var currentButtonIndex: Int = -1;
    var frontViewImage: UIImage? = nil;
    var backViewImage: UIImage? = nil;
    var topViewImage: UIImage? = nil;
    var imageList = [UIImage]()
    var imageIndexList = [Int]()
    var isGoingBack: Bool = false
    
    @IBAction func getViewsImages(_ sender: Any) {
        currentButtonIndex = (sender as AnyObject).tag
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        if(currentButtonIndex == 0) {
            let front = image
            imageList.append(front)
            imageIndexList.append(0)
            frontViewStepIcon.image = UIImage(named: "successful_icon_coloured")
            backViewBtn.isEnabled = true
            backViewButtonIcon.alpha = 1
        } else if(currentButtonIndex == 1) {
            let back = image
            imageList.append(back)
            imageIndexList.append(1)
            backViewStepIcon.image = UIImage(named: "successful_icon_coloured")
            topViewBtn.isEnabled = true
            topViewButtonIcon.alpha = 1
        } else if(currentButtonIndex == 2) {
            let top = image
            imageList.append(top)
            imageIndexList.append(2)
            topViewStepIcon.image = UIImage(named: "successful_icon_coloured")
            continueButton.isEnabled = true
        } else { print("Incorrect button index") }
        
        // print("CreateYourOwn,line: 63: \(imageList.count)")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goingBackToPreviousPage" {
            if segue.destination is ViewController { return }
        } else if segue.destination is PreviewCreateYourOwnPhotosController {
            let previewImagesVC = segue.destination as! PreviewCreateYourOwnPhotosController
            
            previewImagesVC.imageList.append(imageList[0])
            previewImagesVC.imageList.append(imageList[1])
            previewImagesVC.imageList.append(imageList[2])
        }
    }
    
}
