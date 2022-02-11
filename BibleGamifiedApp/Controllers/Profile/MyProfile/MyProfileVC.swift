//
//  MyProfileVC.swift
//  BibleDragDemo
//
//  Created by indianic on 23/11/21.
//

import UIKit
// import SwiftProtobufPluginLibrary

class MyProfileVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var lbltTitle: GradientLabel!
    @IBOutlet weak var imgProfile: UIImageView!

    @IBOutlet weak var lblBirthDate: UILabel!
    @IBOutlet weak var lbluserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var viewBirthDate: UIView!
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var lblLogout: UILabel!

    var objProfileVM = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        configureOnViewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {

        lblLogout.font = R.font.magraBold(size: 25)!

        setData()
        self.lbltTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]
        getUserProfileAPI()

    }

    /// set Profile Data
    private func setData() {
        if let user  = UserManager.shared.current?.data {

            if let full_name = user.full_name {
                lblName.text = full_name
                viewName.isHidden = false
            } else {
                viewName.isHidden = true
            }
            if let email = user.email {
                lblEmail.text = email
                viewEmail.isHidden = false
            } else {
                viewEmail.isHidden = true
            }
            if let birthdate = user.birthdate {
                let birthdDate = Date(fromString: birthdate, format: .custom(DateTimeFormat.dd_MM_yyyy.rawValue))?.toString(format: DateFormatType.custom(DateTimeFormat.dd_MMMM_yyyy.rawValue))
                lblBirthDate.text = birthdDate

                viewBirthDate.isHidden = false
            } else {
                viewBirthDate.isHidden = true
            }
            imgProfile.setImageUsingKF(path: user.avatar ?? "" )

            if let isSocialUser = user.isSocialUser, isSocialUser == true {
                viewUserName.isHidden = true
            } else {

                if let userName = user.userName {
                    lbluserName.text = userName
                    viewUserName.isHidden = false
                } else {
                    viewUserName.isHidden = true
                }
            }
        }
    }

    /// get user profile API
    private func getUserProfileAPI() {
        objProfileVM.setLoginInInfo(UserManager.shared.current?.data?.id ?? 0)
        objProfileVM.callUserProfileAPI { sucess in
            if sucess {
                self.setData()
            }
        }
    }
    @IBAction func btnEditTapped(_ sender: Any) {
        if let avtarVC = R.storyboard.profile.editProfileVC() {
            avtarVC.completionBlock = {
                self.getUserProfileAPI()
            }
            self.pushVC(controller: avtarVC)
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

    @IBAction func btnLogoutAction(_ sender: UIButton) {
        UIAlertController.showAlert(controller: self, title: R.string.localizable.k_appName(), message: R.string.localizable.kLogout(), style: .alert, cancelButton: R.string.localizable.btn_cancel(), distrutiveButton: R.string.localizable.btn_yes(), otherButtons: nil) { (_, btnStr) in
            if btnStr == R.string.localizable.btn_yes() {
                self.logoutAPI()
            }
        }
    }

    /// user logout API
    private func logoutAPI() {
        objProfileVM.callUserLogoutAPI { _ in
            UserManager.shared.removeUser()
            Utility.shared.pauseSound()
            Utility.setRootScreen(isAnimation: true, isShowGameUnlock: false)
        }
    }
}
