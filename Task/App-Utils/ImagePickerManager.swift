//
//  ImagePickerManager.swift
//  Task
//
//  Created by Umakanta Sahoo on 16/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import Foundation
import UIKit


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController()
    var alertVC = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?

    override init(){
        super.init()
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        let cameraAction = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alertVC.addAction(cameraAction)
        alertVC.addAction(galleryAction)
        alertVC.addAction(cancelAction)
        //alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alertVC, animated: true, completion: nil)
    }
    
    
    func openCamera() {
        alertVC.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            viewController?.present(alert, animated: true)
        }
    }
    
    func openGallery() {
        alertVC.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.viewController!.present(picker, animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}
