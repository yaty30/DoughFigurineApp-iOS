//
//  PreviewCreateYourOwnPhotosController.swift
//  MobileAssignment
//
//  Created by James Yip on 3/1/2022.
//

import UIKit

class PreviewCreateYourOwnPhotosController: UIViewController,  UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let db = firebase.db
    
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
    
    func getOrderTimeAndDate(type: String) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = type == "orderDate" ? "yyyy-MM-dd" : "HH:mm:ss"
        
        let result = format.string(from: date)
        
        return "\(result)"
    }
    
    func getSpecificDate( _ type: String) -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let result = type == "year" ? calendar.component(.year, from: date) :
                        type == "month" ? calendar.component(.month, from: date) :
                        calendar.component(.day, from: date)
        
        return "\(result)"
    }
    
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func generateInvoiceID() -> String {
        let date = Date()
        let format = DateFormatter()
        
        format.dateFormat = "yyyyMMddHHmmss"
        
        let invoiceID = format.string(from: date)
        let addon = self.randomString(length: 6)
        
        return "#\(addon)"
    }
    
    @IBAction func createDraftInvoice(_ sender: Any) {
        imageToBase64(converted: {
            // print("done converting at \(getTimeAndDate(type: "time"))...")
            // print(orderImages.frontView)
            invoiceData.invoiceNumber = self.generateInvoiceID()
            invoiceData.orderBy = currentUserData.currentUser
            invoiceData.orderDate = self.getOrderTimeAndDate(type: "orderDate")
            invoiceData.orderDay = self.getSpecificDate("day")
            invoiceData.orderMonth = self.getSpecificDate("month")
            invoiceData.orderYear = self.getSpecificDate("year")
            invoiceData.orderTime = self.getOrderTimeAndDate(type: "orderTime")
            invoiceData.items.append("Customise Dough Figurine")
            invoiceData.itemQty.append("1x $399")
            invoiceData.itemPrices.append(399.00)
            invoiceData.totalPrice = 399.00
            
            orderPayment.paidAmount = 399.00
    //        uploadImage(frontViewData, "#20221221391237_frontView")
        })
    }
    
    func imageToBase64(converted: @escaping () -> Void) {
        // print("start converting at \(getTimeAndDate(type: "time"))...")
        DispatchQueue.main.async {
            let FVimageData = self.frontViewImage.image!.jpegData(compressionQuality: 0.2)
            let BVimageData = self.backViewImage.image!.jpegData(compressionQuality: 0.2)
            let TVimageData = self.topViewImage.image!.jpegData(compressionQuality: 0.2)
            
            orderImages.frontView = (FVimageData?.base64EncodedString())!
            orderImages.backView = (BVimageData?.base64EncodedString())!
            orderImages.topView = (TVimageData?.base64EncodedString())!
            converted()
        }
    }
    
    
    
//    func checkRepeatingID(completion: @escaping (String) -> Void) {
//        let docRef = db.collection("orders").document("#\(findYourOrder.targetInvoiceNumber)")
//        DispatchQueue.main.async {
//            docRef.getDocument { (document, error) in
//
//                if let document = document, document.exists {
//                    completion("exist")
//                } else {
//                    completion("exist")
//                }
//            }
//        }
//    }
}

