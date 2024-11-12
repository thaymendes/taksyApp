//
//  UIViewController+.swift
//  TaskyApp
//
//  Created by Thayanne Mendes on 08/10/24.
//
import UIKit

extension UIViewController {
    
    func addBackgroundGradient(){
        let gradientColor = CAGradientLayer()
        gradientColor.frame = view.bounds
        gradientColor.colors = [UIColor.white.cgColor, UIColor(named: AssestsConstants.lilac)?.cgColor ?? UIColor.purple.cgColor]
        view.layer.insertSublayer(gradientColor, at: 0)
    }
    
}
