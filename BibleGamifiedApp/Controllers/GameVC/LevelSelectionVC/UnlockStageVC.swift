//
//  UnlockStageVC.swift
//  BibleDragDemo
//
//  Created by indianic on 25/11/21.
//

import UIKit

class UnlockStageVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var viewScore: ScoreView!
    @IBOutlet weak var pageControl: PageControl!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitleChooseAvtar: GradientLabel!

    // MARK: Public Properties
    public lazy var objGameVM: GameViewModel = {
        return GameViewModel()
    }()

    var unlockStage = 2
    var starRating = 1
    var  arrGames = [AllGames]()
    var isPushed = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        arrGames = Utility.shared.arrAllGames
        setupCollection()
        getGameLevelAPI()
    }

    /// Setup Collection UI
    private func setupCollection() {
        collectionView.register(cellType: StageCVCell.self)
        Utility.delay(0) { [self] in
            self.lblTitleChooseAvtar.font = R.font.magraBold(size: 27)
            self.lblTitleChooseAvtar.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

            let flowLayout = UICollectionViewFlowLayout()
            self.collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
           flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 5
            flowLayout.scrollDirection = .horizontal
            self.collectionView.collectionViewLayout = flowLayout
            collectionView.isPagingEnabled = true
            self.collectionView.reloadData()
            self.collectionView.contentOffset.x = 0
//            self.btnNextPreviousClick(self.btnPrevious)

        }
    }

    /// get Game level Progress API
     func getGameLevelAPI() {
         objGameVM.getGameLevelProgressAPI(isShowLoader: false) { [self] sucess in
            if sucess {
                /// set current page
                self.viewScore.lblScoreValue.text = "\(self.objGameVM.objGameLevelModel?.totalRatting ?? 0)"
                let totalLevel =  self.objGameVM.objGameLevelModel?.games?.count ?? 0
                self.pageControl.numberOfPages = totalLevel > 8 ? totalLevel / 8 : 1
                self.pageControl.currentPage = 0
                self.collectionView.reloadData()
//                self.btnNextPreviousClick(self.btnPrevious)
            }
        }
    }

    func fetchGameObjectByLevel(arrGamesDataModel: [GamesDataModel], level: Int) -> GamesDataModel? {

        if let objGamesDataModel = arrGamesDataModel.filter({$0.level! == level}).first {
            return objGamesDataModel
        }
        return nil
    }

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       // Or to rotate and lock
        isPushed = false
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeLeft)
        self.viewScore.lblScoreValue.text = "\(self.objGameVM.objGameLevelModel?.totalRatting ?? 0)"
   }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // pageControl.updateDots()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isPushed {
            AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeLeft)
        } else {
            AppUtility.lockOrientation(.all, andRotateTo: .unknown)
        }
    }

    @IBAction func btnNextPreviousClick(_ sender: UIButton) {
        if sender == btnNext {
            collectionView.scrollToNextItem()
        } else {
            collectionView.scrollToPreviousItem()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        btnNext.alpha = pageControl.currentPage == (pageControl.numberOfPages - 1) ? 0.7 : 1
        btnPrevious.alpha = pageControl.currentPage == 0 ? 0.7 : 1
        btnNext.isUserInteractionEnabled = pageControl.currentPage == (pageControl.numberOfPages - 1) ? false : true
        btnPrevious.isUserInteractionEnabled = pageControl.currentPage == 0 ? false : true
    }

}
extension UnlockStageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objGameVM.objGameLevelModel?.games?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StageCVCell = collectionView.dequeueReusableCell(for: indexPath)
        if let levelObject = objGameVM.objGameLevelModel?.games?[indexPath.row] {
            cell.configureCell(object: levelObject)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = CGFloat(10)
        let insetEdge = CGFloat(20)
        let lineSoacing = CGFloat(5)
        let itemWidth = ((collectionView.bounds.size.width - spacing - spacing - spacing) / 4)
        let itemHeight = (collectionView.bounds.size.height - insetEdge - insetEdge - lineSoacing) / 2

        return CGSize(width: itemWidth, height: itemHeight)
       // return CGSize(width: itemWidth, height: indexPath.row <= unlockStage ? itemHeight + 5 : itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if objGameVM.objGameLevelModel?.games?[indexPath.row].ratting ?? -1 >= GameRating.zero.rawValue {
            if let levelObject = objGameVM.objGameLevelModel?.games?[indexPath.row] {
                showGames(objGameLevel: levelObject)
            }
        } else {
            isPushed = true
            if let resultVC = R.storyboard.game.levelBuyVC() {
                resultVC.intTotalStar = (self.objGameVM.objGameLevelModel?.totalRatting ?? 0)
                resultVC.objGamesDataModel = objGameVM.objGameLevelModel?.games?[indexPath.row]
                resultVC.completionBlock = {
                    DispatchQueue.main.async {
                        self.objGameVM.objGameLevelModel?.games?[indexPath.row].ratting = 0
                        self.objGameVM.objGameLevelModel?.games?[indexPath.row].isPurchased = true
                        let totalRating =  (self.objGameVM.objGameLevelModel?.totalRatting ?? 0) -  (self.objGameVM.objGameLevelModel?.games?[indexPath.row].starrequiretounlock ?? 0)
                        self.viewScore.lblScoreValue.text = "\(totalRating)"
                        self.collectionView.reloadData()
                    }

                }
                self.pushVC(controller: resultVC)
                return
            }
        }
    }

    // show games screen
    func showGames(objGameLevel: GamesDataModel) {
        isPushed = true
        if let randomElement = arrGames.randomElement() {
            if  let index = arrGames.firstIndex(of: randomElement) {
                arrGames.remove(at: index)
            }
            Utility.showGames(randomElement: randomElement, VC: self, objGameLevel: objGameLevel)
        } else if let randomElement =  Utility.shared.arrAllGames.randomElement() {
            if  let index = arrGames.firstIndex(of: randomElement) {
                arrGames.remove(at: index)
            }
            Utility.showGames(randomElement: randomElement, VC: self, objGameLevel: objGameLevel)
        }
    }
}
