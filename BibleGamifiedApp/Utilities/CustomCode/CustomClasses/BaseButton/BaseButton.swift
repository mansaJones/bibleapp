//
//  BaseButton.swift
//  GoodwillChoice
//
//  Created by indanic on 03/05/20.
//  Copyright © 2020 IndiaNIC. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class BaseButton: UIButton {

    @IBInspectable var strLocalizeKey: String {
        get {
            return self.localizeKey ?? ""
        }
        set {
            self.localizeKey = newValue
            self.setupUI()
        }
    }

    private var localizeKey: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        if let aKey = self.localizeKey {
            self.setTitle(aKey.localized, for: .normal)
        }
        self.layer.cornerRadius = 8
        self.setTitleColor(UIColor.app.white, for: .normal)
        self.setTitleColor(UIColor.app.white, for: .disabled)
        self.titleLabel?.font = R.font.magraBold(size: 14)
    }
}
