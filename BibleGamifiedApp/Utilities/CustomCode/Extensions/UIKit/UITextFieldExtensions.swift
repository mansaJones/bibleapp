//
//  UITextFieldExtensions.swift
//  StructureApp
// 
//  Created By: Kushal Panchal, IndiaNIC Infotech Ltd
//  Created on: 28/02/18 2:14 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import UIKit

private var maxLengths = [UITextField: Int]()
private var minLengths = [UITextField: Int]()

extension UITextField {

    /// Left padding of the TextField
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    /// Right padding of the TextField
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }

    // MARK: - Maximum length
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return 100
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fixMax), for: .editingChanged)
        }
    }
    @objc func fixMax(textField: UITextField) {
        let text = textField.text
        textField.text = text?.safelyLimitedTo(length: maxLength)
    }

    // MARk:- Minimum length
    @IBInspectable var minLegth: Int {
        get {
            guard let l = minLengths[self] else {
                return 0
            }
            return l
        }
        set {
            minLengths[self] = newValue
            addTarget(self, action: #selector(fixMin), for: .editingChanged)
        }
    }
    @objc func fixMin(textField: UITextField) {
        let text = textField.text
        textField.text = text?.safelyLimitedFrom(length: minLegth)
    }

}
