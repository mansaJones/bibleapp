//
//  cellDragDrop.swift
//  BibleDragDemo
//
//  Created by indianic on 18/11/21.
//

import UIKit

class DragDropCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imgOption: UIImageView!

    @IBOutlet weak var imgHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var imgWidhtConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
