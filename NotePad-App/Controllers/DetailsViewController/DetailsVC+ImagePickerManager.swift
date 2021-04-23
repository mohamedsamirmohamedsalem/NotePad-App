//
//  DetailsVC+ImagePickerManager.swift
//  NotePad-App
//
//  Created by mohamed samir on 23/04/2021.
//

import UIKit
import Photos


extension DetailsViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func pickImageFromDevice() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .savedPhotosAlbum
            authorizePermission(imagePicker)
            
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
    
    func authorizePermission(_ imagePicker: UIImagePickerController){
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:   DispatchQueue.main.async{
                self.present(imagePicker, animated: true, completion: nil)
            }
            case .restricted,.denied: DispatchQueue.main.async{
                self.displayCancelLAlert()
            }
            default: break
            }
            
        }
        
    }
}
