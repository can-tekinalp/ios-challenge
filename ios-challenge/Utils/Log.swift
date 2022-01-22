//
//  Log.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

func log(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}
