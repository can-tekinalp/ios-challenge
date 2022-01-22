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
}
