//
//  URLSession+LoadImage.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 26.01.2022.
//

import UIKit

extension URLSession {
    
    private static let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)

    func loadImage(from url: URL, callbackQueue: DispatchQueue = .main, handler: @escaping (Result<UIImage?, NetworkServiceError>) -> Void) -> URLSessionTask {
        let task = URLSession.session.dataTask(with: url) { data, _, error in
            if let error = error, (error as NSError).code == NSURLErrorCancelled {
                callbackQueue.async {
                    handler(.failure(.canceled))
                }
                return
            }
            guard let data = data else {
                callbackQueue.async {
                    handler(.success(nil))
                }
                return
            }
            let image = UIImage(data: data)
            
            callbackQueue.async {
                handler(.success(image))
            }
        }
        task.resume()
        return task
    }
}
