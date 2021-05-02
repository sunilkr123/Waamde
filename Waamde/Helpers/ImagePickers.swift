//  Created by Apple on 09/09/20.
//  Copyright © 2020 Apple. All rights reserved.

import Foundation
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

//Just add in info.plist for the permission.
//1. NSCameraUsageDescription
//2. NSPhotoLibraryUsageDescription

open class ImagePickers: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        self.pickerController.navigationBar.isTranslucent = false
        self.pickerController.navigationBar.barTintColor = UIColor(red: 29.0 / 255.0, green: 33.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
    }
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type

            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    public func present(from sourceView: UIView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let alertController = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .actionSheet)
        if let action1 = self.action(for: .camera, title: "Camera") {
            alertController.addAction(action1)
        }
        if let action2 = self.action(for: .savedPhotosAlbum, title: "Saved Photo") {
            alertController.addAction(action2)
        }
        if let action3 = self.action(for: .photoLibrary, title: "Gallery") {
            alertController.addAction(action3)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        self.presentationController?.present(alertController, animated: true)
    }
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
    }
}

let imagePath = "data:image/jpeg;base64," //Initial Path for the base4 Conversion

extension ImagePickers: UIImagePickerControllerDelegate {
    func convertImageToBase64String (img: UIImage,compressionQuality:CGFloat) -> String {
        return img.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
//    public func imagePickerController(_ picker: UIImagePickerController,
//                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//
//        guard let image = info[UIImagePickerCon] as? UIImage else {
//            return self.pickerController(picker, didSelect: nil)
//        }
//        self.pickerController(picker, didSelect: image)
//    }
    
   public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("")
        }
        //pickImageCallback?(image)
     self.pickerController(picker, didSelect: image)
    }
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
//            self.pickerController(picker, didSelect: editedImage)
//        } else if let originalimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            self.pickerController(picker, didSelect: originalimage)
//        }
//    }
}
extension ImagePickers: UINavigationControllerDelegate {
    
}
