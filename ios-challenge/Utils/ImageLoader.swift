//
//  ImageLoader.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import SDWebImage
import UIKit

typealias ImageDownloadedHandler = (UIImage?) -> Void
typealias IsLoadingHandler = (Bool) -> Void

protocol ImageLoaderProtocol {
    var imageDownloadedHandler: ImageDownloadedHandler? { get set }
    var isLoadingHandler: IsLoadingHandler? { get set }
    func getImage()
    func cancel()
}

class ImageLoader: ImageLoaderProtocol {
    
    private let imageUrl: URL?
    private var task: URLSessionTask?
    private var cachedImage: UIImage?
    var imageDownloadedHandler: ImageDownloadedHandler?
    var isLoadingHandler: IsLoadingHandler?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    func getImage() {
        if let image = self.cachedImage {
            imageDownloadedHandler?(image)
            return
        }
        
        guard let imageUrl = self.imageUrl else {
            imageDownloadedHandler?(nil)
            return
        }
        
        isLoadingHandler?(true)
        self.task = URLSession.shared.loadImage(from: imageUrl) { [weak self] result in
            self?.isLoadingHandler?(false)
            if let error = result.failure, error == .canceled {
                return
            }
            self?.cachedImage = result.success ?? nil
            self?.imageDownloadedHandler?(result.success ?? nil)
        }
    }
    
    func cancel() {
        task?.cancel()
    }
}
