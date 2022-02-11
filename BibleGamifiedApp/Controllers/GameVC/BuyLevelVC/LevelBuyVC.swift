//
//  LevelBuyVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 17/12/21.
//

import UIKit
import SwiftyStoreKit
import StoreKit

enum RegisteredPurchase: String {

    case purchase1
    case purchase2
    case nonConsumablePurchase
    case consumablePurchase
    case nonRenewingPurchase
    case autoRenewableWeekly
    case autoRenewableMonthly
    case autoRenewableYearly
}

class LevelBuyVC: BaseVC {

    @IBOutlet weak var lblUnlockPaymentAmount: UILabel!
    @IBOutlet weak var lblUsingStar: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblStar: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var btnByStar: UIButton!
    @IBOutlet weak var lblTitle: GradientLabel!

    @IBOutlet weak var viewStarUnlock: UIView!
    @IBOutlet weak var viewPaymentUnlock: UIView!

    var intTotalStar = Int()
    var intRequireStart = Int()
    var objGamesDataModel: GamesDataModel?
    var completionBlock: (() -> Void)?

    public lazy var objGameVM: GameViewModel = {
        return GameViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {

        self.lblTitle.font = R.font.magraBold(size: 27)
        self.lblTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]
        self.lblTitle.text = R.string.localizable.kunlockLevel() + " " + String(objGamesDataModel?.level ?? 0)

        lblStar.text = String(objGamesDataModel?.starrequiretounlock ?? 0) + " " + R.string.localizable.kstar()
        intRequireStart = objGamesDataModel?.starrequiretounlock ?? 0
        lblUnlockPaymentAmount.text = "PAY $" + (objGamesDataModel?.amount ?? "0")

        if objGamesDataModel?.isPaid ?? false && !(objGamesDataModel?.isPurchased ?? false) {
            // this is paid game & need to consume stars or payment to unlock

            lblUsingStar.textColor = intTotalStar >= intRequireStart ? UIColor.white : R.color.d7D7D()
            lblDescription.textColor = intTotalStar >= intRequireStart ? UIColor.white : R.color.d7D7D()
            lblTitle.textColor = intTotalStar >= intRequireStart ? UIColor.white : R.color.d7D7D()

            lblStar.textColor = intTotalStar >= intRequireStart ? R.color.fdbb5A() : R.color.d7D7D()
            let img = intTotalStar >= intRequireStart ? R.image.ic_button_bg() : R.image.ic_btnbggray()
            btnByStar.setBackgroundImage(img, for: .normal)
            btnByStar.isUserInteractionEnabled = intTotalStar >= intRequireStart ? true : false
            imgStar.image = intTotalStar >= intRequireStart ?  R.image.ic_star() : R.image.ic_startgray()
            imgBG.image = intTotalStar >= intRequireStart ? R.image.ic_carddrag() :  R.image.ic_white_back_cover()
            self.viewPaymentUnlock.isHidden = false
        } else {
            // this is free game but need to consume stars to unlock

            lblUsingStar.textColor = intTotalStar >= intRequireStart ? UIColor.white : R.color.d7D7D()
            lblDescription.textColor = intTotalStar >= intRequireStart ? UIColor.white : R.color.d7D7D()
            lblTitle.textColor = intTotalStar >= intRequireStart ? UIColor.white : R.color.d7D7D()

            lblStar.textColor = intTotalStar >= intRequireStart ? R.color.fdbb5A() : R.color.d7D7D()
            let img = intTotalStar >= intRequireStart ? R.image.ic_button_bg() : R.image.ic_btnbggray()
            btnByStar.setBackgroundImage(img, for: .normal)
            btnByStar.isUserInteractionEnabled = intTotalStar >= intRequireStart ? true : false
            imgStar.image = intTotalStar >= intRequireStart ?  R.image.ic_star() : R.image.ic_startgray()
            imgBG.image = intTotalStar >= intRequireStart ? R.image.ic_carddrag() :  R.image.ic_white_back_cover()
            self.viewPaymentUnlock.isHidden = true
        }

        IAP_Helper.shared.getInfo()

    }

    @IBAction func btnBuyStartTapped(_ sender: Any) {
        levelBuyAPI(receipt: "", transacID: "", paymenttype: PurcaseType.Star.rawValue)
    }

    @IBAction func btnPayTapped(_ sender: Any) {
        IAP_Helper.shared.purchase { productID, receiptInfo in
            print("productID = \(productID)")
            print("receiptInfo = \(receiptInfo)")

            self.levelBuyAPI(receipt: receiptInfo, transacID: productID, paymenttype: PurcaseType.Paid.rawValue)
        }
    }

    func levelBuyAPI(receipt: String, transacID: String, paymenttype: String ) {
        objGameVM.objGameInfo.gameid = objGamesDataModel?.gameId ?? 0
        objGameVM.objGameInfo.level = objGamesDataModel?.level ?? 0
        objGameVM.objGameInfo.transactionid = transacID
        objGameVM.objGameInfo.receipt = receipt
        objGameVM.objGameInfo.currency = objGamesDataModel?.currency ?? ""
        objGameVM.objGameInfo.paymenttype = paymenttype
        objGameVM.objGameInfo.starredeemed = intRequireStart

        objGameVM.objGameInfo.amount = Double(objGamesDataModel?.amount ?? "0") ?? 0.0

        objGameVM.callLevelPurchaseAPI { sucess in
            if sucess {
                self.completionBlock?()
                self.poptoVC()
            }
        }
    }
}
