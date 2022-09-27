//
//  UIImage+fixOrientation.swift
//  NeedBuy
//
//  Created by alexKoro on 26.09.22.
//

import Foundation
import UIKit

extension UIImage {
    func fixOrientation() -> UIImage? {
        guard imageOrientation != .up else { return self }
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height)))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
