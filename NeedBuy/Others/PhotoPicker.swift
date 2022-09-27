//
//  PhotoPicker.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import Foundation
import PhotosUI

class PhotoPicker: PHPickerViewControllerDelegate {
    
    static let shared = PhotoPicker()
    private var handler: ((UIImage?) -> ())?
    
    private init() { }
    
    private func createPhotoPickerVC(_ config: PHPickerConfiguration?) -> PHPickerViewController {
        let photoPickerVC: PHPickerViewController!
        
        if let config = config {
            photoPickerVC = PHPickerViewController(configuration: config)
        } else {
            var config = PHPickerConfiguration(photoLibrary: .shared())
            config.filter = .images
            config.selectionLimit = 1
            photoPickerVC = PHPickerViewController(configuration: config)
        }
        photoPickerVC.delegate = self
        
        return photoPickerVC
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        results.first?.itemProvider.loadObject(
            ofClass: UIImage.self,
            completionHandler: { [weak self] result, error in
                guard let image = result as? UIImage,
                      let fixedImage = image.fixOrientation(),
                      error == nil else { return }
                self?.handler?(fixedImage)
                }
            )
    }
    
    func create(with handler: @escaping (UIImage?) -> ()) -> PHPickerViewController {
        self.handler = handler
        let picker = createPhotoPickerVC(nil)

        return picker
    }
}
