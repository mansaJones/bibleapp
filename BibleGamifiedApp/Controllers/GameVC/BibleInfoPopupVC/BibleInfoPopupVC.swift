//
//  BibleInfoPopupVC.swift
//  BibleDragDemo
//
//  Created by indianic on 24/11/21.
//

import UIKit
import Spring
import Lottie
import dotLottie

class BibleInfoPopupVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var btnClose: UIButton!

     var strTitle: String?
     var strMessage: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Or to rotate and lock
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
        // Don't forget to reset when view is being removed
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        self.lblTitle.text = strTitle ?? ""
        self.lblMessage.text = strMessage ?? ""
        addBlurBG()
    }

    func addBlurBG() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        // always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.view.bringSubviewToFront(successView)
    }

    /// BUtton Close Clikc
    /// - Parameter sender:  Pop to Gameunlock screen
    @IBAction func btnCloseClick(_ sender: UIButton) {
        self.poptoDismiss()
    }

}
