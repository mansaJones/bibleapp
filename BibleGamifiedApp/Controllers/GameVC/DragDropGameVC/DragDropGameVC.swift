//
//  DragDropGameVC.swift
//  BibleDragDemo
//
//  Created by indianic on 18/11/21.
//

import UIKit

class DragDropGameVC: BaseVC {

    @IBOutlet weak var collectionMatch: UICollectionView!
    @IBOutlet weak var btnMuteUnMute: UIButton!
    @IBOutlet weak var btnPausePlay: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var viewProgress: ProgressView!
    @IBOutlet var imgOptions: [UIImageView]!
    @IBOutlet var vieOptions: [UIView]!

    var arrimageCollections = [DataClass]()
    var isPushToVC = false
    var objGamesDataModel: GamesDataModel?
    var arrDragElemenet =  [DragDropData]()
    var randomElement: DragDropData?
    var model = DragDropModel()
    var  arrGames = [AllGames]()

    var intGameLifeLeft = Utility.shared.intGameLife

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureOnViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPushToVC = false
        self.view.isUserInteractionEnabled = true
        // Or to rotate and lock
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
        self.manageMuteUnmuteBG()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewProgress.timer?.invalidate()
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)

    }

    func timerInvalid() {
        collectionMatch.isUserInteractionEnabled = false
        viewProgress.timerInvalid()
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        arrGames = Utility.shared.arrAllGames

        viewProgress.timerBlock = { (actionType, timer) in
            switch actionType {

            case .timeStart:
                self.lblTimer.text = timer

            case .timeEnd:
                self.showSucessScreen(isSucesss: true)
            }
        }
        collectionMatch.register(cellType: DragDropCell.self)
        collectionMatch.reloadData()
        setupDargDrop()

    }

    /// setup drag drop with pass destination view
    func setupDargDrop() {
        Utility.shared.totalGameDuration = Float(objGamesDataModel?.timer ?? 0)
        arrDragElemenet = model.getData()
        for i in (0..<arrDragElemenet.count) {
            imgOptions[i].image =  UIImage(named: arrDragElemenet[i].displayImage)
        }
        randomElement = arrDragElemenet.randomElement()
        let indexOfAnimal = arrDragElemenet.firstIndex {$0 === randomElement} // 0
        arrimageCollections.append(DataClass(imageName: randomElement!.rightImage))
        collectionMatch.reloadData()

        self.items_CollectionView = collectionMatch
        self.itemsCollections = arrimageCollections
        self.destinationView = vieOptions[indexOfAnimal ?? 0]
        self.addGesturesForCollectionView()

        super.destinationMatchBlock = { (sucess) in
            if sucess {
                // transitionFlipFromRight
                // transitionCrossDissolve
                UIView.transition(with: self.imgOptions[indexOfAnimal ?? 0], duration: 1, options: .transitionCrossDissolve, animations: {
                    self.imgOptions[indexOfAnimal ?? 0].image = UIImage(named: self.randomElement!.fileddipslayImage)
                    Utility.delay(1) {
                        self.showSucessScreen(isSucesss: true)
                    }
                }, completion: nil)

            } else {

                Utility.delay(0.5) {
                    self.intGameLifeLeft  =  self.intGameLifeLeft - 1
                    self.showSucessScreen(isSucesss: self.intGameLifeLeft == 0 ? true : false)
                }

            }
        }
    }

    /// Show sucess screen while game match object
    func showSucessScreen(isSucesss: Bool) {
        self.view.isUserInteractionEnabled = false
        Utility.delay(0) {
            if isSucesss {
                self.btnPausePlay.isUserInteractionEnabled = false
                self.collectionMatch.isUserInteractionEnabled = false
                self.timerInvalid()
                if let resultVC = R.storyboard.game.successLevelVC() {
                    resultVC.objGamesDataModel = self.objGamesDataModel
                    resultVC.successRattingCount =  self.intGameLifeLeft == 0 ? 0 : self.viewProgress.getGameStarCount()
                    resultVC.restartGameBlock = { (gameModel) in
                        if let objetc = gameModel {
                            if let randomElement = self.arrGames.randomElement() {
                                if  let index = self.arrGames.firstIndex(of: randomElement) {
                                    self.arrGames.remove(at: index)
                                }
                                Utility.showGames(randomElement: randomElement, VC: self, objGameLevel: objetc)
                            }
                        }
                        /* old code
                        if let resultVC = R.storyboard.game.dragDropGameVC() {
                            resultVC.objGamesDataModel = gameModel
                            self.pushVC(controller: resultVC)
                        }
                        */
                    }
                    self.presentVC(controller: resultVC)
                }
            } else {
                if let resultVC = R.storyboard.game.resultVC() {
                    resultVC.lifeUsed = self.intGameLifeLeft
                    resultVC.imgSelected = UIImage(named: self.randomElement!.rightImage)!
                    self.isPushToVC = true

                    self.timerInvalid()
                    resultVC.playaginBlock = {
                        // self.viewProgress.totaHeight = 0
                        // self.viewProgress.progressContant.constant = 0
                        // self.viewProgress.counter = Utility.shared.totalGameDuration
                        self.viewProgress.scheduleTimer()
                        self.collectionMatch.isUserInteractionEnabled = true
                        self.btnPausePlay.isUserInteractionEnabled = true
                    }

                    super.doSomeThingsAfterPanCompletion()
                    self.btnPausePlay.isUserInteractionEnabled = false
                    self.collectionMatch.isUserInteractionEnabled = false
                    self.pushVC(controller: resultVC)
                }
            }
        }
    }

    @IBAction func btnPlayPauseClick(_ sender: UIButton) {
        if viewProgress.counter <= 0 {
            return
        }
        if sender.isSelected {
            collectionMatch.isUserInteractionEnabled = true
            viewProgress.scheduleTimer()
        } else {
            timerInvalid()
        }
        sender.isSelected = !sender.isSelected
    }

    // MARK: Private Methods
    fileprivate func manageMuteUnmuteBG() {
        if UDSettings.isSoundPlaying {
            self.btnMuteUnMute.setImage(R.image.ic_unMute_btn(), for: .normal)
        } else {
            self.btnMuteUnMute.setImage(R.image.ic_mute(), for: .normal)
        }
    }

    @IBAction func btnMuteClick(_ sender: UIButton) {

        if UDSettings.isSoundPlaying {
            Utility.shared.pauseSound()
        } else {
            Utility.shared.playSound()
            //            self.btnMuteUnMute.setImage(R.image.ic_mute(), for: .normal)
        }
        self.manageMuteUnmuteBG()
    }

}

extension DragDropGameVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrimageCollections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aDragDropCell: DragDropCell = collectionMatch.dequeueReusableCell(for: indexPath)

        aDragDropCell.imgHeightConstant.constant = collectionView.frame.height - 10
        aDragDropCell.imgWidhtConstant.constant = collectionView.frame.height - 10
        aDragDropCell.imgOption.image = UIImage(named: arrimageCollections[indexPath.row].imageName)

        return aDragDropCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
