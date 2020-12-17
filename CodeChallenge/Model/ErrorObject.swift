//
//  ErrorObject.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation

// MARK: - ErrorObject
struct ErrorObject: Codable, Error {
    let success: Bool
    let error: ErrorInfo
}

// MARK: - ErrorInfo
struct ErrorInfo: Codable {
    let code: Int
    let info: String
}
