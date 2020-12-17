//
//  Currency.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}

// MARK: - Rates
struct Rates: Codable {

    
}
