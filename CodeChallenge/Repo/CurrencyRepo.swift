//
//  CurrencyRepo.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//


import Foundation
protocol CurrencyRepo {
    func listCurrency(completionHandeler: @escaping (Result<Currency,ErrorObject>)->Void)
}

class CurrencyRepoImpl: CurrencyRepo {
    func listCurrency(completionHandeler: @escaping (Result<Currency, ErrorObject>) -> Void) {
        ApiRequest.apiCall(responseModel: Currency.self, request: .latest) { response in
            switch response {
            case .success(let currency):
                completionHandeler(.success(currency))
            case .failure(let error):
                completionHandeler(.failure(error))
            }
        }
    }
    
}
