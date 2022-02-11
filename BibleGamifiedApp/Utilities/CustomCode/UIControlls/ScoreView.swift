//
//  ScoreView.swift
//  BibleDragDemo
//
//  Created by apple on 26/11/21.
//

import Foundation
import UIKit
class ScoreView: UIView, NibOwnerLoadable {

    @IBOutlet weak var lblScoreValue: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()
    }
}
