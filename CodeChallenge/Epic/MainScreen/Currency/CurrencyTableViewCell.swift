//
//  CurrencyTableViewCell.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    func configure(currencyName: String, currencyValue: Double){
        self.name.text = currencyName
        self.value.text = String(currencyValue)
    }

}
