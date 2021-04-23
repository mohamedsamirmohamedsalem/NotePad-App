//
//  Image.swift
//  NotePad-App
//
//  Created by mohamed samir on 23/04/2021.
//

import UIKit

extension NSData{
    func convertFromNSDataToImage(_ data : NSData) -> UIImage {
        return ( UIImage(data: data as Data) ?? UIImage()  )
    }
}
