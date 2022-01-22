//
//  Routes.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import Alamofire

let baseURL = "https://api.themoviedb.org/3"

enum ApiRoutes {
    case nowPlaying
    case upcoming
    case detail(String)
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .upcoming:
            return "/movie/upcoming"
        case .detail(let id):
            return "/movie/\(id)"
        }
    }
    
    var urlString: String {
        return "\(baseURL)\(path)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: HTTPHeaders {
        return .default
    }
    
    func buildRequest(parameters: [String: Any]) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.name) }
        var finalParameters = parameters
        finalParameters["api_key"] = apiKey
        return try? encoding.encode(urlRequest, with: finalParameters)
    }
}
