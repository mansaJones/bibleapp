//
//  StageCVCell.swift
//  BibleDragDemo
//
//  Created by indianic on 25/11/21.
//

import UIKit

class StageCVCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var lblUnlockPrice: UILabel!
    @IBOutlet weak var viewLocked: UIView!
    @IBOutlet weak var viewUnlocked: UIView!
    @IBOutlet weak var viewPaid: UIView!

    @IBOutlet weak var lblStageNumber: UILabel! {
        didSet {
            let font = Device.current.isXSeriesDevice ? R.font.magraBold(size: 34)! : R.font.magraBold(size: 28)!
            lblStageNumber.font = font
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(object: GamesDataModel) {
        lblStageNumber.text = String(object.level ?? 0)

        print("rating is", object.ratting ?? -1)
        viewLocked.isHidden = false
        viewUnlocked.isHidden = true

        if let isPaid = object.isPaid, isPaid {
            viewPaid.isHidden = false
            lblUnlockPrice.text = "$" + (object.amount ?? "0")
        } else {
            viewPaid.isHidden = true
        }

        switch object.ratting ?? -1 {

        case GameRating.zero.rawValue:
            viewLocked.isHidden = true
            viewUnlocked.isHidden = false
            imgStar1.image = R.image.ic_unfilled_star()!
            imgStar3.image = R.image.ic_unfilled_star()!
            imgStar2.image = R.image.ic_unfilled_star()!

        case GameRating.one.rawValue:
            viewLocked.isHidden = true
            viewUnlocked.isHidden = false
            imgStar1.image = R.image.ic_filled_star()!
            imgStar2.image = R.image.ic_unfilled_star()!
            imgStar3.image = R.image.ic_unfilled_star()!

        case GameRating.two.rawValue:
            viewLocked.isHidden = true
            viewUnlocked.isHidden = false
            imgStar1.image = R.image.ic_filled_star()!
            imgStar2.image = R.image.ic_filled_star()!
            imgStar3.image = R.image.ic_unfilled_star()!

        case GameRating.three.rawValue:
            viewLocked.isHidden = true
            viewUnlocked.isHidden = false
            imgStar1.image = R.image.ic_filled_star()!
            imgStar2.image = R.image.ic_filled_star()!
            imgStar3.image = R.image.ic_filled_star()!

        default:

            break
        }
    }

}
