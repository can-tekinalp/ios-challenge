//
//  ImageLoader.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import SDWebImage
import UIKit

protocol ImageLoaderProtocol {
    var showLoadingHandler: ShowLoadingHandler? { get set }
    func getImage(completionHandler: @escaping (UIImage?) -> Void)
}

class ImageLoader: ImageLoaderProtocol {
    
    private let imageUrl: URL?
    var showLoadingHandler: ShowLoadingHandler?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    func getImage(completionHandler: @escaping (UIImage?) -> Void) {
        showLoadingHandler?(true)
        SDWebImageManager.shared.loadImage(imageUrl) { [weak self] image in
            self?.showLoadingHandler?(false)
            completionHandler(image)
        }
    }
}
