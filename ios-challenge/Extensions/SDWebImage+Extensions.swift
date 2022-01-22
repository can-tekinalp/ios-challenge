//
//  SDWebImage+Extensions.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import SDWebImage

extension SDWebImageManager {
    
    func loadImage(_ url: URL?, completionHandler: @escaping (UIImage?) -> Void) -> SDWebImageCombinedOperation? {
        return SDWebImageManager.shared.loadImage(with: url, options: [.refreshCached], progress: nil) { image, _, _, _, _, _ in
            completionHandler(image)
        }
    }
}
