//
//  LeadershipBoardVC.swift
//  BibleDragDemo
//
//  Created by indianic on 23/11/21.
//

import UIKit

class LeadershipBoardVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var lblRanking: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet var viewFooter: UIView!
    @IBOutlet weak var lbltTitle: GradientLabel!
    @IBOutlet weak var tblLeaderShip: UITableView!

    // MARK: Public Properties
    public lazy var objLeadeBoardVM: LeadeBoardViewModel = {
        return LeadeBoardViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        configureOnViewDidLoad()
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        let colorTop =  R.color.gra1000000()!.cgColor
        let colorBottom = R.color.gra3000000()!.cgColor
        let colorMid = R.color.gra2000000()!.cgColor
        self.tblLeaderShip.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)

        viewFooter.setGradientBackground(gradianColor: [colorTop, colorMid, colorBottom ])
        tblLeaderShip.register(cellType: LeadershipBoardTVCell.self)

        self.lbltTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]
        viewFooter.isHidden = true
        resetLeaderData()
        getMyRankingAPI()

    }

    /// set Rank User Data
    private func setRankingData() {
        if let dataRanking = objLeadeBoardVM.objLeaderBoardDataModel {
            imgUser.setImageUsingKF(path: dataRanking.avatar ?? "" )
            lblRank.text = dataRanking.rank?.ordinal
            lblUserName.text = dataRanking.fullName ?? ""

            lblRanking.text = String(dataRanking.rating ?? 0)
            viewFooter.isHidden = false
        }
    }
    /// reset leadership data
    private func resetLeaderData() {
        self.objLeadeBoardVM.reset()
        self.getLeadershipListDataAPI(true)

    }

    /// get Leadership Data API
    /// - Parameter isShowLoader: Bool
    private func getLeadershipListDataAPI(_ isShowLoader: Bool = true) {
        objLeadeBoardVM.getLeadeBoard(isShowLoader) { sucess in
            if sucess {
                self.tblLeaderShip.reloadData()
            }
        }
    }

    /// get my ranking API
    private func getMyRankingAPI() {
        objLeadeBoardVM.getMyRanking { sucess in
            if sucess {
                self.setRankingData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

    }

}
extension LeadershipBoardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objLeadeBoardVM.objLeaderBoardModel?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LeadershipBoardTVCell = tableView.dequeueReusableCell(for: indexPath)
        if let object = objLeadeBoardVM.objLeaderBoardModel?.data?[indexPath.row] {
            cell.configureCell(object: object)
        }
//        startAnimation(tableView: tableView)
        cell.imgLeaderShipBG.image = indexPath.row <= 2 ? R.image.ic_leadership_bg_orange()! : R.image.ic_leadership_bg_gray()!

        cell.imgUserFrame.image = indexPath.row <= 2 ? R.image.ic_frame()! : R.image.ic_user_frame()!
        cell.lblRanking.isHidden = indexPath.row <= 2 ? false : true
        cell.lblUserName.textColor = indexPath.row <= 2 ? UIColor(named: "gradient4") : UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.3, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

        // Check if you have the Pagination data or not.
        guard let aLocalPaginationData = objLeadeBoardVM.objLeaderBoardModel?.meta else { return }
        guard let aLocalAllFeedsData = objLeadeBoardVM.objLeaderBoardModel?.data else { return }

        let aTotalRow = tableView.numberOfRows(inSection: 0)

        // Request for more data only if the current data count is less than the total number of records on the server.
        if  (aTotalRow == indexPath.row + 1) && aLocalPaginationData.total ?? 0 > aLocalAllFeedsData.count {
            objLeadeBoardVM.updatePageInfo(((aLocalPaginationData.currentPage ?? 0) + 1))
            objLeadeBoardVM.getLeadeBoard(false) { _ in
                self.tblLeaderShip.reloadData()

            }
        }

        // MARK: Animation function
//        cell.alpha = 0
//        UIView.animate(
//            withDuration: 0.3,
//            delay: 0.02 * Double(indexPath.row),
//            animations: {
//                cell.alpha = 1
//        })

    }
}
