//
//  SDWebImage+Extensions.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import SDWebImage

extension SDWebImageManager {
    
    func loadImage(_ url: URL?, completionHandler: @escaping (UIImage?) -> Void) {
        SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { image, _, _, _, _, _ in
            completionHandler(image)
        }
    }
}
