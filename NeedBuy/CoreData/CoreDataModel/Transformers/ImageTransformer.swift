//
//  ImageTransformer.swift
//  NeedBuy
//
//  Created by alexKoro on 29.07.22.
//

import Foundation
import UIKit

@objc(ImageTransformer)
class ImageTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        
        let data = image.pngData()
        
        return data
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        let image = UIImage(data: data)
        
        return image
    }
}
