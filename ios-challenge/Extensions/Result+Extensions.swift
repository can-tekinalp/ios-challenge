//
//  Result+Extensions.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

extension Result {
    
    var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
