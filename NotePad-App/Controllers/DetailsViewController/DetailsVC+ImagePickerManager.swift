//
//  DetailsVC+ImagePickerManager.swift
//  NotePad-App
//
//  Created by mohamed samir on 23/04/2021.
//

import UIKit

extension DetailsViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func pickImageFromDevice() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .savedPhotosAlbum
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]{
            pickedImage.image = image as? UIImage
        }
        imagePickerControllerDidCancel(picker)
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
