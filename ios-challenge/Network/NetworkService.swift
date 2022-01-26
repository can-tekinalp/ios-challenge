//
//  NetworkService.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import Alamofire

extension String: Error { }

class NetworkService {
    
    static let shared = NetworkService()
    
    @discardableResult
    func request<T: Decodable>(decodable : T.Type, route: ApiRoutes, parameters: [String: Any], dispatchOn: DispatchQueue = .main, handler: @escaping (Result<T, NetworkServiceError>) -> Void) -> DataRequest? {
        guard let request = route.buildRequest(parameters: parameters) else {
            handler(.failure(.other(unexpectedErrorMessage)))
            return nil
        }
    
        return AF.request(request).responseDecodable(of: T.self) { (dataResponse) in
            dispatchOn.async { [weak self] in
                self?.handleResponse(response: dataResponse, handler: handler)
            }
        }
    }
    
    private func handleResponse<T: Decodable>(response: DataResponse<T, AFError>, handler: @escaping (Result<T, NetworkServiceError>) -> Void) {
        switch response.result {
        case .success(let response):
            handler(.success(response))
        case .failure(let error):
            switch error {
            case .explicitlyCancelled:
                handler(.failure(.canceled))
            default:
                handler(.failure(.other(unexpectedErrorMessage)))
            }
            log(error)
        }
    }
}
