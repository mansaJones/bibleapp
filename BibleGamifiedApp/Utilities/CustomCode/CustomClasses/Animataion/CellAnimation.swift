//
//  CellAnimation.swift
//  StructureApp
//
//  Created by indianic on 27/08/19.
//  Copyright © 2019 IndiaNIC Infotech Ltd. All rights reserved.
//

import Foundation
import UIKit

// HOW TO USE::
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.moveInAnimation(forIndex: indexPath.row)
//    }

extension UITableViewCell {

    /// Table view cell fade in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.1
    ///   - index: cell index
    func fadeInAnimation(withDuration duration: Double = 0.1, forIndex index: Int) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: (duration * Double(index)), animations: {
            self.alpha = 1.0
        }, completion: nil)
    }

    /// Table view cell bounce animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.8
    ///   - delay: animation delay default value 0.05
    ///   - index: cell index
    func bouncingAnimation(withDuration duration: Double = 0.8, withDelay delay: Double = 0.05, forIndex index: Int) {
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: duration, delay: delay * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    /// Table view cell move in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.5
    ///   - delay: animation delay default value 0.08
    ///   - index: cell index
    func moveInAnimation(withDuration duration: Double = 0.5, withDelay delay: Double = 0.08, forIndex index: Int) {
        self.alpha = 0
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height / 2)
        UIView.animate(withDuration: duration, delay: delay * Double(index), animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    /// Table view cell right side to in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.5
    ///   - delay: animation delay default value 0.08
    ///   - index: cell index
    func rightInAnimation(withDuration duration: Double = 0.5, withDelay delay: Double = 0.08, forIndex index: Int) {
        self.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
        UIView.animate(withDuration: duration, delay: delay * Double(index), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    /// Table view cell left side to in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.5
    ///   - delay: animation delay default value 0.08
    ///   - index: cell index
    func leftInAnimation(withDuration duration: Double = 0.5, withDelay delay: Double = 0.08, forIndex index: Int) {
        self.transform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
        UIView.animate(withDuration: duration, delay: delay * Double(index), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}

extension UICollectionViewCell {

    /// Table view cell fade in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.1
    ///   - index: cell index
    func fadeInAnimation(withDuration duration: Double = 0.1, forIndex index: Int) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: (duration * Double(index)), animations: {
            self.alpha = 1.0
        }, completion: nil)
    }

    /// Table view cell bounce animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.8
    ///   - delay: animation delay default value 0.05
    ///   - index: cell index
    func bouncingAnimation(withDuration duration: Double = 0.8, withDelay delay: Double = 0.05, forIndex index: Int) {
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: duration, delay: delay * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    /// Table view cell move in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.5
    ///   - delay: animation delay default value 0.08
    ///   - index: cell index
    func moveInAnimation(withDuration duration: Double = 0.5, withDelay delay: Double = 0.08, forIndex index: Int) {
        self.alpha = 0
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height / 2)
        UIView.animate(withDuration: duration, delay: delay * Double(index), animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    /// Table view cell right side to in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.5
    ///   - delay: animation delay default value 0.08
    ///   - index: cell index
    func rightInAnimation(withDuration duration: Double = 0.5, withDelay delay: Double = 0.08, forIndex index: Int) {
        self.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
        UIView.animate(withDuration: duration, delay: delay * Double(index), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    /// Table view cell left side to in animation for best way to represent
    /// tableview
    ///
    /// - Parameters:
    ///   - duration: animation duration default value 0.5
    ///   - delay: animation delay default value 0.08
    ///   - index: cell index
    func leftInAnimation(withDuration duration: Double = 0.5, withDelay delay: Double = 0.08, forIndex index: Int) {
        self.transform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
        UIView.animate(withDuration: duration, delay: delay * Double(index), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}
