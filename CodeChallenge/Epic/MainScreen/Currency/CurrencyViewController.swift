//
//  CurrencyViewController.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ActionSheetPicker_3_0

class CurrencyViewController: UIViewController {
    @IBOutlet weak var currencyPickerBtn: UIButton!
    @IBOutlet weak var currencyRateTableView: UITableView!
    
    var viewModel = CurrencyViewModel(currencyRepo: CurrencyRepoImpl())
    var disposeBag = DisposeBag()
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.getCurrencyRates()
        currencyPickerBtnWasTapped()
        bindData()
    }
    
    func bindData() {
        self.subscribeErrorMessage()
        self.subscribeActivityIndecator()
        self.subscribeCurrencyRatesResponse()
        self.tableViewBinder()
    }
    
    func subscribeCurrencyRatesResponse(){
        self.viewModel.currencyRatesResponse.bind { currencyRatesResponse in
            self.countries = currencyRatesResponse.map{$0.key}
        }.disposed(by: disposeBag)
    }
    
    func tableViewBinder() {
        self.viewModel.currencyRatesResponse.bind(to: currencyRateTableView.rx.items(cellIdentifier: "CurrencyTableViewCell", cellType: CurrencyTableViewCell.self)) {(row, currency, cell) in
            cell.configure(currencyName: currency.key, currencyValue: currency.value)
        }.disposed(by: disposeBag)
    }
    
    func currencyPickerBtnWasTapped(){
        self.currencyPickerBtn.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe { [weak self] (_) in
            self?.presentPickerView(content: self?.countries ?? [])
        }.disposed(by: disposeBag)
    }
    
    func subscribeErrorMessage(){
        self.viewModel.errorMessage.subscribe(onNext: { [weak self] errorMessage in
            self?.alert(message: errorMessage, actions: [("OK", .cancel)])
        }).disposed(by: disposeBag)
    }
    
    func subscribeActivityIndecator(){
        self.viewModel.activityIndecator.subscribe(onNext: { [weak self] isSpanning in
            isSpanning ? self?.showSpinner(onView: self!.view) : self?.removeSpinner()
        }).disposed(by: disposeBag)
    }
    
    func presentPickerView(content: [String]){
        let sortedContent = content.sorted()
        ActionSheetStringPicker.show(withTitle: "Countries", rows: sortedContent, initialSelection: 0, doneBlock: { _, _, value in
            self.viewModel.getCurrencyRates()
            self.currencyPickerBtn.setTitle("\(value ?? "")", for: .normal)
            return
        }, cancel: { _ in return }, origin: UIButton())
    }
    
}

