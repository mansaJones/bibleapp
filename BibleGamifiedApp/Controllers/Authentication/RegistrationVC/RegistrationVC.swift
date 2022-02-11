//
//  LoginVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit
import Spring

class RegistrationVC: BaseVC {

    // MARK: - 📣 Outlets
    /// RegistrationVC Section
    @IBOutlet weak var lblTitleSignup: GradientLabel!

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var tfFullName, tfUsername, tfEmailID, tfBirthday, tfParentsEmailID, tfReferralCode: BGTextField!

    // MARK: - Private Properties
    private lazy var registerVM: RegisterViewModel = {
        return RegisterViewModel()
    }()

    override func viewDidLoad() {

        super.viewDidLoad()

        lblNext.attributedText = R.string.localizable.kNext().getButtonAttributedTitle()

        self.lblTitleSignup.font = R.font.magraBold(size: 27)
        self.lblTitleSignup.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextAction(_ sender: UIButton) {
        if isValidate() {
            updateRegisterInfo()
            if let registrationPassVC = R.storyboard.main.registrationPassVC() {
                registrationPassVC.objRegisterVM =  registerVM
                self.pushVC(controller: registrationPassVC)
            }
        }
    }

    func updateRegisterInfo() {
        registerVM.objRegiterModel.fullName  = tfFullName.text ?? ""
        registerVM.objRegiterModel.user_name  =  tfUsername.text ?? ""
        registerVM.objRegiterModel.email  =  tfEmailID.text ?? ""
        registerVM.objRegiterModel.birth_date  =  tfBirthday.text ?? ""
        registerVM.objRegiterModel.parent_email_id  =  tfParentsEmailID.text ?? ""
        registerVM.objRegiterModel.referral_code  =  tfReferralCode.text ?? ""

    }
}

// MARK: - Validation- AND API

extension RegistrationVC {

    /// validation method to validate Data
    func isValidate() -> Bool {

        var isValidate = true

        if (tfFullName.text ?? "").isBlank {
            tfFullName.shake()
            AlertMesage.show(.error, message: R.string.localizable.kfullname())
            isValidate = false

        } else if !(tfFullName.text ?? "").checkMin(length: CharLimit.fullNameMin.rawValue) {
            tfFullName.shake()
            AlertMesage.show(.error, message: R.string.localizable.kNameLimit())
            isValidate = false

        } else if (tfUsername.text ?? "").isBlank {
            tfUsername.shake()
            AlertMesage.show(.error, message: R.string.localizable.kuserName())
            isValidate = false

        } else if !(tfUsername.text ?? "").checkMin(length: CharLimit.fullNameMin.rawValue) {
            tfUsername.shake()
            AlertMesage.show(.error, message: R.string.localizable.kUserNameLimit())
            isValidate = false

        } else if !(tfEmailID.text ?? "").isEmail {
            tfEmailID.shake()
            AlertMesage.show(.error, message: R.string.localizable.kemail())
            isValidate = false

        } else if (tfBirthday.text ?? "").isBlank {
            tfBirthday.shake()
            AlertMesage.show(.error, message: R.string.localizable.kbirthdate())
            isValidate = false

        } else if (tfBirthday.text ?? "").isUserAdult() == false && ((tfParentsEmailID.text ?? "").isBlank || !(tfParentsEmailID.text ?? "").isEmail) {
            tfParentsEmailID.shake()
            AlertMesage.show(.error, message: R.string.localizable.kparentsemail())
            isValidate = false

        }
        return isValidate
    }

}

// MARK: - UITextFieldDelegate delegates and datasource method

extension RegistrationVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfBirthday {
            DatePicker.pickDate(txtField: tfBirthday, VC: self, datePickerMode: UIDatePicker.Mode.date) { strDate, isDismss in
                if !isDismss {
                    self.tfBirthday.text = strDate
                }
                self.tfBirthday.resignFirstResponder()
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfFullName {
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if isBackSpace == -92 {
                    return true
                }
            }
            if !(textField.text ?? "").checkMax(length: CharLimit.fullName.rawValue) {
                return false
            }
        }
        return true
    }
}
