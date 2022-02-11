//
//  VideoVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 23/11/21.
//

import UIKit

class VideoVC: BaseVC {

    var aTitle: String = R.string.localizable.kVideos()

    @IBOutlet weak var lblTitle: GradientLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.font = R.font.magraBold(size: 27)
        self.lblTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        // Do any additional setup after loading the view.
        self.lblTitle.text = aTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
