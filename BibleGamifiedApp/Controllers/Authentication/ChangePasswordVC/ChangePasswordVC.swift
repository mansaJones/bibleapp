//
//  LoginVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var lblRemainTime: UILabel!
    @IBOutlet weak var lblTitleResetPassword: GradientLabel!
    @IBOutlet weak var btnSumit: UIButton!
    @IBOutlet weak var lblSumit: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var tfEmailUsername: UITextField!

    let loginViewModel = LoginViewModel()
    var timer: Timer?
    var counter: Float = 25
    var isSubmited = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()

    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        btnResend.isUserInteractionEnabled = false

        lblSumit.attributedText = R.string.localizable.kSUBMIT().getButtonAttributedTitle()
        self.btnResend.setUnderLineButtonWith(font: R.font.magraBold(size: 13)!)
        self.lblTitleResetPassword.font = R.font.magraBold(size: 27)
        self.lblTitleResetPassword.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

        self.setTransperantNavigationBar()

    }
    func scheduleTimer() {
        btnResend.isUserInteractionEnabled = false
        timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    }

    @objc func timerElapsed() {
        counter -= 1
        _ = Int(counter) / 3600
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60

       let totalTime = String(format: "%02d:%02d", minutes, seconds)
        lblRemainTime.text = "in " + totalTime + " " +  (R.string.localizable.ksecond())
       if counter == 0 {
        // Stop when timer reaches 0
        timer?.invalidate()
        btnResend.isUserInteractionEnabled = true
       }
    }

    @IBAction func btnBackAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitAction(_ sender: UIButton) {
        if !isSubmited {
            apiForgotPasswordAPI()
        }

    }

    func apiForgotPasswordAPI() {
        if emailValidation(txtEmail: tfEmailUsername) {
            loginViewModel.callForgotPasswordAPI { (_) in
                self.isSubmited = true
                self.scheduleTimer()
            }
        }
    }

    func emailValidation(txtEmail: UITextField) -> Bool {
        if (txtEmail.text ?? "").isBlank {
            txtEmail.shake()
            AlertMesage.show(.error, message: R.string.localizable.kemail())
            return false
        } else if !(txtEmail.text ?? "").isEmail {
            txtEmail.shake()
            AlertMesage.show(.error, message: R.string.localizable.kemail())
            return false
        }
        return true
    }

    @IBAction func btnResendTapped(_ sender: Any) {
        counter = 25
        apiForgotPasswordAPI()
    }
}

// MARK: - Validation- AND API

extension ChangePasswordVC {
    /// validation method to validate Data
    func isValidate() -> Bool {
        var isValidate = true
        if !(tfEmailUsername.text ?? "").isEmail {
            tfEmailUsername.shake()
            AlertMesage.show(.error, message: R.string.localizable.kemail())
            isValidate = false

        }
        return isValidate
    }
}
