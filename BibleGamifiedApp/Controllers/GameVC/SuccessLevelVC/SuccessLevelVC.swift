//
//  SuccessLevelVC.swift
//  BibleDragDemo
//
//  Created by indianic on 24/11/21.
//

import UIKit
import Spring
import Lottie
import dotLottie

class SuccessLevelVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var viewImg1: SpringView!
    @IBOutlet weak var viewImg2: SpringView!
    @IBOutlet weak var viewImg3: SpringView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var img3: UIImageView!

    // MARK: Public Properties
    public lazy var objGameVM: GameViewModel = {
        return GameViewModel()
    }()

    var restartGameBlock: ((GamesDataModel?) -> Void)?
    public lazy var animationView: AnimationView = {
        return AnimationView()
    }()
    var objGamesDataModel: GamesDataModel?
    var successRattingCount: Int = 0

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
        addBlurBG()
        self.manageStarRattingAnimations()
    }

    /// Update Game level Progress API
    func updateProgressLevelAPI() {

        objGameVM.setGameLevelInfo(objGamesDataModel?.gameId ?? 0, objGamesDataModel?.level ?? 0, objGamesDataModel?.timer ?? 0, successRattingCount)
        objGameVM.callLevelProgressUpdateAPI { sucess in
            if sucess {
                self.setNvigation()
            } else {
                self.btnClose.isUserInteractionEnabled = true
            }
        }
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
        btnClose.isUserInteractionEnabled = false
        if successRattingCount > 0 {
            updateProgressLevelAPI()
        } else {
            setNvigation()
        }
    }

    private func setNvigation() {
        if successRattingCount > 0 {
            if objGamesDataModel?.level ?? 0 == objGameVM.objGameModel?.totallevel ?? 0 {
                AlertMesage.show(.info, message: R.string.localizable.k_allLevelComplete())
                Utility.setRootScreen(isAnimation: false, isShowGameUnlock: true)
            } else {
                restartGameBlock?(objGameVM.objGameModel)
                self.poptoDismiss()
            }

        } else {
            // self.poptoGameUnlockVC()
            Utility.setRootScreen(isAnimation: false, isShowGameUnlock: true)
        }
    }
}

extension SuccessLevelVC {

    fileprivate func manageStarRattingAnimations() {

        switch successRattingCount {

        case GameRating.zero.rawValue :
            lblTitle.text = R.string.localizable.k_levelIncomplte()
            self.img1.image = R.image.ic_star3_unfilled()
            self.img2.image = R.image.ic_star3_unfilled()
            self.img3.image = R.image.ic_star3_unfilled()
            lblResult.text = GameRating.zero.getTitle()

        case GameRating.one.rawValue:
            self.img1.image = R.image.ic_star1_filled()
            self.img2.image = R.image.ic_star3_unfilled()
            self.img3.image = R.image.ic_star3_unfilled()
            lblResult.text = GameRating.one.getTitle()

        case GameRating.two.rawValue:
            self.img1.image = R.image.ic_star1_filled()
            self.img2.image = R.image.ic_star2_filled()
            self.img3.image = R.image.ic_star3_unfilled()
            lblResult.text = GameRating.two.getTitle()

        case GameRating.three.rawValue:
            self.img1.image = R.image.ic_star1_filled()
            self.img2.image = R.image.ic_star2_filled()
            self.img3.image = R.image.ic_star2_filled()
            lblResult.text = GameRating.three.getTitle()

        default:
            break
        }

        delay(delay: 0.5) {
            self.viewImg1.isHidden = false
            self.viewImg1.animate()
        }

        delay(delay: 1) {
            self.viewImg2.isHidden = false
            self.viewImg2.animate()
        }

        delay(delay: 1.5) {
            self.viewImg3.isHidden = false
            self.viewImg3.animate()
        }

        if successRattingCount > 0 {
            delay(delay: 2) {
                DotLottie.load(name: Constant.kCelebrationAnimation, cache: .ignoreCache) { animation, _ in
                    if let animation = animation {
                        self.animationView.animation = animation
                        self.animationView.bounds = CGRect(x: 0, y: 0, width: self.view.size.width, height: self.view.size.height)
                        self.animationView.center = self.view.center

                        self.view.addSubview(self.animationView)
                        self.view.bringSubviewToFront(self.btnClose)
                        self.animationView.play { _ in
                            self.animationView.removeFromSuperview()
                        }
                    } else {
                        print("Error loading .lottie")
                    }
                }
            }
        }
    }
}
