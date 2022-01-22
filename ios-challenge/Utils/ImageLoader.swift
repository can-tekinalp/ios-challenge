//
//  ImageLoader.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import SDWebImage
import UIKit

typealias ImageLoadCompletionHandler = (UIImage?) -> Void

protocol ImageLoaderProtocol {
    var cachedImage: UIImage? { get }
    var showLoadingHandler: ShowLoadingHandler? { get set }
    func getImage(completionHandler: @escaping ImageLoadCompletionHandler)
}

class ImageLoader: ImageLoaderProtocol {
    
    private let imageUrl: URL?
    private var operation: SDWebImageCombinedOperation?
    var cachedImage: UIImage?
    var showLoadingHandler: ShowLoadingHandler?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    func getImage(completionHandler: @escaping ImageLoadCompletionHandler) {
        if let image = cachedImage {
            completionHandler(image)
            return
        }
        showLoadingHandler?(true)
        operation?.cancel()
        operation = SDWebImageManager.shared.loadImage(imageUrl) { [weak self] image in
            self?.showLoadingHandler?(false)
            self?.cachedImage = image
            completionHandler(image)
        }
    }
}
