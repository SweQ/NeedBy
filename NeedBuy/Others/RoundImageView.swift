//
//  RoundImageView.swift
//  NeedBuy
//
//  Created by alexKoro on 19.09.22.
//

import UIKit

class RoundImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.cornerRadius = self.bounds.height / 2
        
    }

}
