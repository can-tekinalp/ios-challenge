//
//  NetworkServiceError.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import Foundation

enum NetworkServiceError: Error {
    case canceled
    case other(String)
    
    var message: String {
        switch self {
        case .other(let message):
            return message
        default:
            return unexpectedErrorMessage
        }
    }
}

extension NetworkServiceError: Equatable { }
