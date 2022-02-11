//
//  LoginVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit

class TermsConditionVC: UIViewController {

    @IBOutlet weak var lblTitle: GradientLabel!
    @IBOutlet weak var txtTermsCondition: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.font = R.font.magraBold(size: 27)
        self.navigationController?.isNavigationBarHidden = false

        self.lblTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    @IBAction func btnBackAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
