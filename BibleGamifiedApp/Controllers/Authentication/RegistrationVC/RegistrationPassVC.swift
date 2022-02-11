//
//  LoginVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit

class RegistrationPassVC: BaseVC {

    @IBOutlet weak var lblTitleSignup: GradientLabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfrimPassword: UITextField!
    @IBOutlet weak var btnTermsConditionCheckmark: UIButton!

    var objRegisterVM = RegisterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        lblNext.attributedText = R.string.localizable.kSUBMIT().getButtonAttributedTitle()

        self.lblTitleSignup.font = R.font.magraBold(size: 27)
        self.lblTitleSignup.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setTransperantNavigationBar()
    }

    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnTermsConditionAction(_ sender: UIButton) {

    }

    @IBAction func btnTermsConditionCheckmarkAction(_ sender: UIButton) {
        if btnTermsConditionCheckmark.isSelected {
            btnTermsConditionCheckmark.isSelected = false
        } else {
            btnTermsConditionCheckmark.isSelected = true
        }
    }

    @IBAction func btnNextAction(_ sender: UIButton) {
        if isValidate() {
            manageHandleRegister()
        }
    }

}

// MARK: - Validation- AND API

extension RegistrationPassVC {

    /// validation method to validate Data
    func isValidate() -> Bool {

        var isValidate = true

        if (tfPassword.text ?? "").isBlank {
            tfPassword.shake()
            AlertMesage.show(.error, message: R.string.localizable.kpassword())
            isValidate = false

        } else  if !(tfPassword.text ?? "").isValidPassword {
            tfPassword.shake()
            AlertMesage.show(.error, message: R.string.localizable.kvalidPassoword())
            isValidate = false

        } else if (tfConfrimPassword.text ?? "").isBlank {
            tfConfrimPassword.shake()
            AlertMesage.show(.error, message: R.string.localizable.kconfirmpassword())
            isValidate = false

        } else if tfPassword.text !=  tfConfrimPassword.text {
            AlertMesage.show(.error, message: R.string.localizable.kpassowordnotsame())
            isValidate = false

        } else if !btnTermsConditionCheckmark.isSelected {
            AlertMesage.show(.error, message: R.string.localizable.kCheckTermsCondition())
            isValidate = false
        }
       return isValidate
    }
}

extension RegistrationPassVC {

    /// handleSubmitAction - Handle the Register API handle go to the Login screen.
    func manageHandleRegister() {
        objRegisterVM.setRegisterInInfo(tfPassword.text ?? "", tfConfrimPassword.text ?? "")
        objRegisterVM.callMakeRegisterAPI { status in
            if status {
//                self.poptoLoginScreen()
                Utility.shared.initSoundToPlay()
                APPDELEGATE.homeNavigationVC = self.navigationController as! HomeNavigationController
                self.performSegue(withIdentifier: R.segue.registrationPassVC.segueShowDashboard, sender: nil)
            }
        }
    }
}
