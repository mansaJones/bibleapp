//
//  LeadershipBoardTVCell.swift
//  BibleDragDemo
//
//  Created by indianic on 23/11/21.
//

import UIKit

class LeadershipBoardTVCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblRanking: UILabel!
    @IBOutlet weak var imgUserFrame: UIImageView!
    @IBOutlet weak var imgLeaderShipBG: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(object: LeaderBoardDataModel) {
        imgUser.setImageUsingKF(path: object.avatar ?? "" )
        lblRanking.text = object.rank?.ordinal
        lblUserName.text = object.fullName ?? ""
        lblRating.text = String(object.rating ?? 0)
    }

}
