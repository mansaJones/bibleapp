//
//  UICollectionView+Extentions.swift
//  BibleGamifiedApp
//
//  Created by apple on 14/12/21.
//

import Foundation
import UIKit
extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.frame.origin.x + self.frame.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.frame.origin.x - self.frame.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset: CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset - 5, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
        self.scrollRectToVisible(frame, animated: true)
    }
}
