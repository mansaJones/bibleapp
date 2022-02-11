//
//  MainDashboardVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 15/11/21.
//

import UIKit
import SwiftyStoreKit

class MainDashboardVC: BaseVC {
    @IBOutlet weak var collectionViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionDashboard: UICollectionView!
    @IBOutlet weak var lblTitle: GradientLabel!
    @IBOutlet weak var lblRestoreTitle: GradientLabel!
    @IBOutlet weak var btnMusic: UIButton!

    let arrDashboardList = MainDashboardItemModel.shared.fetchMainDashboardList()
    var isShow = Bool()
    var spacing = 10.0

    public lazy var objGameVM: GameViewModel = {
        return GameViewModel()
    }()

    var  arrGames = [AllGames]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnViewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.all, andRotateTo: .unknown)
        self.manageMuteUnmuteBG()
        Utility.delay(0.1) {
            self.collectionDashboard.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        collectionViewHeightConstant.constant = collectionDashboard.contentSize.height
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        Utility.delay(0.1) {
            self.collectionDashboard.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Utility.delay(0.1) {
            self.collectionViewHeightConstant.constant = self.collectionDashboard.contentSize.height
        }
    }

    // MARK: Private Methods
    fileprivate func manageMuteUnmuteBG() {
        if UDSettings.isSoundPlaying {
            self.btnMusic.setImage(R.image.ic_unMute_btn(), for: .normal)
        } else {
            self.btnMusic.setImage(R.image.ic_mute(), for: .normal)
        }
    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        arrGames = Utility.shared.arrAllGames

        if isShow {
            showUnlockLevel()
        }

        self.lblTitle.font = R.font.magraBold(size: 27)
        self.lblTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        self.lblRestoreTitle.font = R.font.magraBold(size: 20)
        self.lblRestoreTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        getGameLevelAPI()
    }

    /// get Game level Progress API
    func getGameLevelAPI() {
        objGameVM.getGameLevelProgressAPI(isShowLoader: false) { sucess in
            if sucess {
            }
        }
    }

    func showUnlockLevel() {
        if let controller = R.storyboard.game.unlockStageVC() {
            self.pushVC(controller: controller)
        }
    }

    @IBAction func btnMusicAction(_ sender: UIButton) {

        if UDSettings.isSoundPlaying {
            Utility.shared.pauseSound()
        } else {
            Utility.shared.playSound()
        }
        self.manageMuteUnmuteBG()
    }

    /// Handle the restore inapp purhcase related code..
    /// - Parameter sender:
    @IBAction func btnRestoreInAppAction(_ sender: UIButton) {

        self.handleRestorePurchases()
    }
}

extension MainDashboardVC {

    fileprivate func handleRestorePurchases() {

        Utility.showSimpleHUD()

        SwiftyStoreKit.restorePurchases(atomically: true) { results in

            Utility.dismissHUD()

            for purchase in results.restoredPurchases {
                let downloads = purchase.transaction.downloads
                if !downloads.isEmpty {
                    SwiftyStoreKit.start(downloads)
                } else if purchase.needsFinishTransaction {
                    // Deliver content from server, then:
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }

            if results.restoreFailedPurchases.count > 0 {
                self.present(IAP_Helper.shared.alertWithTitle(R.string.localizable.kRestoreFailedTitle(), message: R.string.localizable.kUnknownErrorMsg()), animated: true, completion: nil)
            } else if results.restoredPurchases.count > 0 {
                self.present(IAP_Helper.shared.alertWithTitle(R.string.localizable.kPurchasesRestoredTitle(), message: R.string.localizable.kPurchasesRestoredMSG()), animated: true, completion: nil)
            } else {
                self.present(IAP_Helper.shared.alertWithTitle(R.string.localizable.kNothingRestoreTitle(), message: R.string.localizable.kNothingRestoreMSG()), animated: true, completion: nil)
            }
        }
    }
}

extension MainDashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrDashboardList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let dashboardCollectionViewCell: DashboardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dashboardCollectionViewCell.identifier, for: indexPath) as? DashboardCollectionViewCell {

            if self.arrDashboardList.count > 0 {

                let objDashboardItem = self.arrDashboardList[indexPath.row]

                dashboardCollectionViewCell.lblCategoryName.text = objDashboardItem.dashboardItemName
                dashboardCollectionViewCell.imgCategoryName.image = objDashboardItem.dashboardItemImage
            }

            return dashboardCollectionViewCell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return 0.0
        }
        return Device.current.isXSeriesDevice ? spacing : 0

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fixHeightWidth = 140.0
        if !Device.current.isXSeriesDevice {
            return CGSize(width: fixHeightWidth, height: fixHeightWidth)
        } else if UIApplication.shared.statusBarOrientation.isLandscape {
            return CGSize(width: (collectionView.width - spacing)/3, height: fixHeightWidth)
        } else {
            return CGSize(width: (collectionView.width - spacing)/2, height: fixHeightWidth)
        }
    }

    func showGameVC () {
        if arrGames.count <= 0 {
            arrGames = Utility.shared.arrAllGames
        }
        if let objGameLevel = self.objGameVM.objGameLevelModel?.games?.filter({ $0.ratting == 0 }).first {
            if var navstack = navigationController?.viewControllers {
                if let resultVC = R.storyboard.game.unlockStageVC() {
                    resultVC.objGameVM =  objGameVM
                    navstack.append(contentsOf: [resultVC])
                }
                if let randomElement = arrGames.randomElement() {
                    if  let index = arrGames.firstIndex(of: randomElement) {
                        arrGames.remove(at: index)
                    }
                    switch randomElement {
                    case .dragDrop:
                        if let resultVC = R.storyboard.game.dragDropGameVC() {
                            navstack.append(contentsOf: [resultVC])
                            resultVC.objGamesDataModel = objGameLevel
                            self.pushVC(controller: resultVC)
                        }

                    case .cardMatch:
                        if let resultVC = R.storyboard.game.cardMatchingVC() {
                            resultVC.objGamesDataModel = objGameLevel
                            navstack.append(contentsOf: [resultVC])
                        }
                    }
                }
                navigationController?.setViewControllers(navstack, animated: true)

            } else {
                if let resultVC = R.storyboard.game.unlockStageVC() {
                    self.pushVC(controller: resultVC)
                }
            }
        } else {
            if let resultVC = R.storyboard.game.unlockStageVC() {
                self.pushVC(controller: resultVC)
            }
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.row {
        case DashboardItems.game.rawValue:

            showGameVC()

        case DashboardItems.leadershipboard.rawValue:
            if let resultVC = R.storyboard.leadershipBoard.leadershipBoardVC() {
                self.pushVC(controller: resultVC)
            }
        case DashboardItems.events.rawValue:
            if let resultVC = R.storyboard.leadershipBoard.videoVC() {
                resultVC.aTitle = R.string.localizable.kEvents()
                self.pushVC(controller: resultVC)
            }
        case DashboardItems.challanges.rawValue:
            if let resultVC = R.storyboard.leadershipBoard.videoVC() {
                resultVC.aTitle = R.string.localizable.kChallenges()
                self.pushVC(controller: resultVC)
            }
        case DashboardItems.videos.rawValue:
            if let resultVC = R.storyboard.leadershipBoard.videoVC() {
                resultVC.aTitle = R.string.localizable.kVideos()
                self.pushVC(controller: resultVC)
            }
        case DashboardItems.refer.rawValue:
            if let referFriendVC = R.storyboard.referFriend.referFriendVC() {
                self.pushVC(controller: referFriendVC)
            }
        default:
            break
        }
    }
}
