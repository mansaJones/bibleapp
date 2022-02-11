//
//  LoginVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit
import PMSuperButton

// MARK: - 🚧 Development Status - ✅ Completed ✅
/// 📣`LoginVC`
/// -  ` Usage ` : -- `Business Rules:`
/// A user can login using email and password.
/// If the email is incorrect, does not exist or email and password combination does not match, an error message will appear.
/// If the user has not created their account and added directly by the respective admin, then after successfully signing in, the user will redirect to change password screen from where he can set a new password for their account.
class LoginVC: BaseVC {

    // MARK: - 📣 Outlets
    /// Login Section
    @IBOutlet weak var btnSumit: PMSuperButton!
    @IBOutlet weak var lblSumit: UILabel!

    @IBOutlet weak var tfEmailUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    @IBOutlet weak var btnFacebookSigning, btnGoogleSigning, btnAppleSigning: UIButton!

    var strEmailID: String = ""
    var strSocialID: String = ""
    var strSocialType: socialLoginType = .kApple

    // MARK: - Private Properties
    lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel()
    }()

    // MARK: - 📣 Variables | Public - Private Properties
    /// Private Properties
    // MARK: - ✅ View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - ✅ Memory MGT
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - ✅ StatusBar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    // MARK: - 🆗 Button Action Events 🆗
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        self.manageHandleLoginAction()
    }

    @IBAction func btnFacebookSigningAction(_ sender: UIButton) {

        self.handleFacebookLoginAction()
    }

    @IBAction func btnGoogleSigningAction(_ sender: UIButton) {
        self.handleGoogleLoginAction(self)
    }

    @IBAction func btnAppleSigningAction(_ sender: UIButton) {
        self.handleAppleLoginAction()
    }

    // MARK: - 💢 Fileprivate Methods 💢
    // MARK: - ⚠️ configureOnViewDidLoad UI
    /// `Description` : -  This function will use for configure UI When Controller init - Function for basic view setup
    fileprivate func configureOnViewDidLoad() {
        lblSumit.attributedText = R.string.localizable.kSUBMIT().getButtonAttributedTitle()
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
}
