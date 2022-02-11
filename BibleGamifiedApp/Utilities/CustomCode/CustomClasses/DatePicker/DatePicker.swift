//
//  MainDashboardVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit

// Properties
//

typealias completionBlock = (_ strData: String, _ isDismiss: Bool) -> Void

var block: completionBlock!
var datePicker = UIDatePicker()
var parentVC = UIViewController()

// Age of 18.
let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -3, to: Date())!

// Age of 100.
let MAXIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date())!

class DatePicker: NSObject {

    /// Call this function to present date picker on textfield
    class func pickDate(txtField: UITextField, VC: UIViewController, strMaxDate: String? = nil, datePickerMode: UIDatePicker.Mode, selectedDate: Date? = Date(), completion: @escaping completionBlock) {
        parentVC = VC
        datePicker.date = selectedDate ?? Date()
        txtField.tintColor = UIColor.clear
        datePicker.datePickerMode = datePickerMode
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -3, to: Date())!
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!

        if strMaxDate != nil {
            let dateFormater = DateFormatter()
            if datePickerMode == .date {
                dateFormater.dateFormat = DateTimeFormat.yyyy_MM_dd.rawValue
            } else {
                dateFormater.dateFormat = DateTimeFormat.yyyy_MM_dd.rawValue
            }
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.backgroundColor = UIColor.white

        if !(txtField.text?.isEmpty)! {
            let dateFormatter = DateFormatter()
            if datePickerMode == .date {
                dateFormatter.dateFormat = DateTimeFormat.yyyy_MM_dd.rawValue
                if strMaxDate != nil {
                        datePicker.setDate(Date(), animated: false)
                }

            } else {
                dateFormatter.dateFormat = DateTimeFormat.time.rawValue
                if let date = dateFormatter.date(from: txtField.text!) {
                    datePicker.setDate(date, animated: false)
                }
            }
        }

        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.barTintColor = R.color.a4C1A00()!
        toolBar.tintColor = .white
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: R.string.localizable.kDone(), style: .plain, target: self, action: #selector(DatePicker.doneClick))
        doneButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.magra(size: 15)!], for: UIControl.State.normal)
        doneButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.magra(size: 15)!], for: UIControl.State.selected)

        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: R.string.localizable.kCancel(), style: .plain, target: self, action: #selector(DatePicker.cancelClick))
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.magra(size: 15)!], for: UIControl.State.normal)
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.magra(size: 15)!], for: UIControl.State.selected)

        doneButton.tintColor = UIColor.white
        cancelButton.tintColor = UIColor.white

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtField.inputView = datePicker
        txtField.inputAccessoryView = toolBar
        block = completion
    }

    @objc class func doneClick() {

//        let isValidAge = validateAge(birthDate: datePicker.date)
//        if isValidAge {
//
//        } else {
//            AlertMesage.show(.error, message: Localizable.validation.birthdateValid)
//
//        }

        let dateFormatter = DateFormatter()

        if datePicker.datePickerMode == .date {
            dateFormatter.dateFormat = DateTimeFormat.dd_MM_yyyy.rawValue
            let aString = dateFormatter.string(from: datePicker.date)
            block(aString, false)
        } else {
            dateFormatter.dateFormat = DateTimeFormat.dd_MM_yyyy.rawValue
            let aString = dateFormatter.string(from: datePicker.date)
            block(aString, false)
        }

        //        block(aString)
        parentVC.view.endEditing(true)

    }

    class  func validateAge(birthDate: Date) -> Bool {
            var isValid: Bool = true

            if birthDate < MAXIMUM_AGE || birthDate > MINIMUM_AGE {
                isValid = false
            }
            return isValid
    }

    @objc class func cancelClick() {
        block("", true)

        parentVC.view.endEditing(true)
    }
}
