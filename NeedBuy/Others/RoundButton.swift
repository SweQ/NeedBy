//
//  RoundButton.swift
//  NeedBuy
//
//  Created by alexKoro on 11.09.22.
//

import UIKit

class RoundButton: UIButton {
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.cornerRadius = bounds.height / 2
    }
    
}
