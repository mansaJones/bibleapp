//
//  ResultVC.swift
//  BibleDragDemo
//
//  Created by indianic on 23/11/21.
//

import UIKit
import AudioToolbox

class ResultVC: BaseVC {

    @IBOutlet var imgLifeDead: [UIImageView]!
    @IBOutlet var imgCorrect: [UIImageView]!
    @IBOutlet var imgLife: [UIImageView]!

    var playaginBlock: (() -> Void)?
    var imgSelected = UIImage()
    var lifeUsed = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {

        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        //imgLife[0].image = imgSelected
        //imgLife[1].image = imgSelected
        //imgLife[2].image = imgSelected

        switch lifeUsed {
        case 3:
            imgLifeDead[0].isHidden = false
            imgLifeDead[1].isHidden = false
            imgLifeDead[2].isHidden = false

        case 2:
            imgLifeDead[0].isHidden = false
            imgLifeDead[1].isHidden = true
            imgLifeDead[2].isHidden = true

        case 1:
            imgLifeDead[0].isHidden = false
            imgLifeDead[1].isHidden = false
            imgLifeDead[2].isHidden = true

        default:
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)

       // Or to rotate and lock
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)

   }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed

        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)

    }

    @IBAction func btnPlayAgainTapped(_ sender: Any) {
        playaginBlock?()
        self.btnPopController(sender)
    }

}
