//
//  Extension+ActivityIndecator.swift
//  CodeChallenge
//
//  Created by Abdelrahman Sobhy on 12/17/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

var spinner : UIView?

extension UIViewController {
    
    /// Init Activity Indicator
    func showSpinner(onView : UIView, alphaColor: CGFloat? = nil) {
        let spinnerView = UIView.init(frame: onView.bounds)
        
        spinnerView.backgroundColor = UIColor.init(red: 255.0, green: 255.0, blue: 255.0, alpha: alphaColor ?? 1)
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        /// Loading Lable
        let loadingLable: UILabel = UILabel()
        loadingLable.frame = CGRect(x: 50, y: 150, width: 200, height: 21)
        loadingLable.textColor = UIColor.black
        loadingLable.textAlignment = NSTextAlignment.center
        loadingLable.translatesAutoresizingMaskIntoConstraints = false
        loadingLable.font = UIFont(name: "Avenir", size: 13)
        loadingLable.text = "Loading..."
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            spinnerView.addSubview(loadingLable)
            /// Loading lable constrints
            loadingLable.topAnchor.constraint(equalTo: ai.bottomAnchor, constant: 8).isActive = true
            loadingLable.centerXAnchor.constraint(equalTo: ai.centerXAnchor, constant: 3).isActive = true
            onView.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    /// Dismiss Activity Indicator
    func removeSpinner() {
        spinner?.removeFromSuperview()
        spinner = nil
    }
}

extension UIActivityIndicatorView {
    func startSpinner() {
        startAnimating()
        isHidden = false
        isUserInteractionEnabled = false
    }

    func stopSpinner() {
        stopAnimating()
        isHidden = true
        isUserInteractionEnabled = true
    }
}
