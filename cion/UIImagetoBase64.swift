//
//  UIImagetoBase64.swift
//  cion
//
//  Created by Rahul K M on 28/02/24.
//

import Foundation
import UIKit

class UIImageToBase64 {
    static func convert(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 1.0) ?? Data()
        return imageData.base64EncodedString(options: .endLineWithCarriageReturn)
    }
}
