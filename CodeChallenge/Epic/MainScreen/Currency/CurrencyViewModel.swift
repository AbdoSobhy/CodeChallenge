//
//  CurrencyViewController.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CurrencyViewModel {

    var currencyRepo: CurrencyRepo
        
    private var currencyRatesSubject = PublishSubject<[String: Double]>()
    var currencyRatesResponse: Observable<[String: Double]>{return currencyRatesSubject}
    var errorMessage = BehaviorRelay<String>(value: "")
    var activityIndecator = BehaviorRelay<Bool>(value: false)
    init(currencyRepo: CurrencyRepo) {
        self.currencyRepo = currencyRepo
    }
    
    func getCurrencyRates(){
        self.activityIndecator.accept(true)
        self.currencyRepo.listCurrency { [weak self] response in
            switch response {
            case .success(let currency):
                self?.currencyRatesSubject.onNext(currency.rates)
            case .failure(let error):
                self?.errorMessage.accept(error.error.info)
            }
            self?.activityIndecator.accept(false)
        }
    }
}
