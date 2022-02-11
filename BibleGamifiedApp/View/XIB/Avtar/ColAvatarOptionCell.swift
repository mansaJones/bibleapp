//
//  ColAvatarOptionCell.swift
//  Commissioning
//
//  Created by indianic on 20/08/21.
//  Copyright © 2021 IndiaNIC. All rights reserved.
//

import UIKit

class ColAvatarOptionCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var imgViewAvatar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /// configureCell: Call this method to configure cell
    /// - Parameters:
    ///   - imgae: imgae
    ///   - isSelected: isSelected
    func configureCell(imgae: UIImage?, isSelected: Bool) {
        let color = isSelected ? UIColor.lightGray :  UIColor.clear
        self.viewAvatar.addShadowBorder(color: color)
        self.imgViewAvatar.image = imgae
    }

}
