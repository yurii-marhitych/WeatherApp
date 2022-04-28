//
//  DesignableView.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit

@IBDesignable
class DesignableView: UIView {

    // MARK: - Inspectable Properties
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerCurve = .continuous
            layer.cornerRadius = cornerRadius
        }
    }
}
