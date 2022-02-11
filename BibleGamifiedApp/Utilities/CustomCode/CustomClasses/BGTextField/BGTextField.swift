//
//  CustomTextField.swift
//  BibleDragDemo
//
//  Created by indianic on 22/11/21.
//

import Foundation
import UIKit

class BGTextField: UITextField {

    lazy var innerShadow: CALayer = {
        let innerShadow = CALayer()
        layer.addSublayer(innerShadow)
        return innerShadow
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        applyDesign()
    }

    func applyDesign() {
        self.tintColor = UIColor.white
        innerShadow.frame = bounds
        let radius = 5
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -8, dy: -8), cornerRadius: CGFloat(radius))
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: CGFloat(radius)).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.darkGray.cgColor
        innerShadow.shadowOffset = CGSize(width: 5, height: 5)
        innerShadow.shadowOpacity = 0.8
        innerShadow.shadowRadius = 6
        innerShadow.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.addGradientLayer([R.color.gradient1()!, R.color.gradient2()!])
        self.gradientBorder(width: 2, colors: [R.color.gradient4()!, R.color.gradient3()!], andRoundCornersWithRadius: 5.0)

    }

}
