//
//  EditProfileVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 22/11/21.
//

import UIKit

/// Edit controller allow user to update pesonal information
/// Profile Storyboard

class EditProfileVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var lbltTitle: GradientLabel!
    @IBOutlet weak var imgProfile: UIImageView!

    // MARK: Variable
    @IBOutlet weak var tfFullName, tfUsername, tfEmailID, tfBirthday, tfParentsEmailID: BGTextField!
    var isFromSignup = Bool()
    var objProfileVM = ProfileViewModel()
    var completionBlock: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnViewDidLoad()
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        tfFullName.delegate  = self
        // getUserProfileAPI()
        self.lbltTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        setData()
    }

    /// set Profile Data
    private func setData() {
        if let user  = UserManager.shared.current?.data {
            self.lbltTitle.text = isFromSignup ? R.string.localizable.kComProfile() :  R.string.localizable.kEditProfile()
            imgProfile.setImageUsingKF(path: user.avatar ?? "" )
            imgProfile.contentMode = .scaleAspectFit
            tfFullName.text = user.full_name ?? ""
            tfUsername.text = user.userName ?? ""
            tfEmailID.text = user.email ?? ""
            tfBirthday.text = user.birthdate ?? ""
            tfParentsEmailID.text = user.parentEmail ?? ""
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

    }

    // MARK: Private Methods

    @IBAction func btnSaveTapped(_ sender: Any) {
        if isValidate() {

            updateUserProfileAPI()
        }
    }

    /// Button Action method for Choose Avtar
    /// - Parameter sender: Object of the Button
    @IBAction func btnAvtarTapped(_ sender: UIButton) {
        if let avtarVC = R.storyboard.avtarCreation.avatarCreationVC() {
            avtarVC.completionBlock = {
                self.completionBlock?()
                self.setData()
            }
            self.pushVC(controller: avtarVC)
        }
    }
}

// MARK: - UITextFieldDelegate delegates and datasource method

extension EditProfileVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfBirthday {

            let pickerDate = getDateFromString(DateTimeFormat.dd_MM_yyyy.rawValue, dateString: textField.text!)

            DatePicker.pickDate(txtField: tfBirthday, VC: self, strMaxDate: nil, datePickerMode: .date, selectedDate: pickerDate) { strDate, isDismss in
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

// MARK: - Validation- AND API

extension EditProfileVC {

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

        } else if (tfBirthday.text ?? "").isBlank {
            tfBirthday.shake()
            AlertMesage.show(.error, message: R.string.localizable.kbirthdate())
            isValidate = false

        } else if (tfBirthday.text ?? "").isUserAdult() == false && ((tfParentsEmailID.text ?? "").isBlank || !(tfParentsEmailID.text ?? "").isEmail) {
            tfParentsEmailID.shake()
            AlertMesage.show(.error, message: R.string.localizable.kparentsemail())
            isValidate = false

        } else if (tfBirthday.text ?? "").isUserAdult()  && tfParentsEmailID.text?.count ?? 0 > 0 &&  !(tfParentsEmailID.text ?? "").isEmail {
            tfParentsEmailID.shake()
            AlertMesage.show(.error, message: R.string.localizable.kparentsemail())
            isValidate = false

        }
       return isValidate
    }

    /// Update User Profile API
    private func updateUserProfileAPI() {
        updateRegisterInfo()
        objProfileVM.setLoginInInfo(UserManager.shared.current?.data?.id ?? 0)
        objProfileVM.callMakeUpdateProfileAPI { sucess in
            if sucess {
                if  self.isFromSignup {
                    UDSettings.isUserLogin = true
                    Utility.setRootScreen(isAnimation: true, isShowGameUnlock: false)
                } else {
                    self.completionBlock?()
                    self.poptoVC()
                }

            }
        }
    }

    func updateRegisterInfo() {
        objProfileVM.objRegiterModel.fullName  = tfFullName.text ?? ""
        objProfileVM.objRegiterModel.user_name  =  tfUsername.text ?? ""
        objProfileVM.objRegiterModel.email  =  tfEmailID.text ?? ""
        objProfileVM.objRegiterModel.birth_date  =  tfBirthday.text ?? ""
        objProfileVM.objRegiterModel.parent_email_id  =  tfParentsEmailID.text ?? ""
        objProfileVM.objRegiterModel.referral_code  =   UserManager.shared.current?.data?.referralCode ?? ""
    }
}
