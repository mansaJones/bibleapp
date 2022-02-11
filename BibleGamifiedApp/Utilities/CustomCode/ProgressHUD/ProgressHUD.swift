//
//  Created by BibleGamifiedApp
//  Copyright © BibleGamifiedApp All rights reserved.
//  Created on 04/02/21

import UIKit

class ProgressHUD {

    class func show() {
        self.displaySpinner()
    }

    class func hide() {
        self.removeSpinner()
    }

    private class func displaySpinner() {
        DispatchQueue.main.async {
            guard let keyWindow = KEY_WINDOW else {return}
            for view in (keyWindow.subviews) where view.tag == 500 {
                view.removeFromSuperview()
            }
            let blurView = UIView()
            blurView.frame = (keyWindow.bounds)
            blurView.tag = 500
            blurView.backgroundColor = UIColor.clear
            let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
            activityIndicatorView.color = UIColor.blue
            activityIndicatorView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
            activityIndicatorView.center = blurView.center
            blurView.addSubview(activityIndicatorView)
            KEY_WINDOW?.addSubview(blurView)
            activityIndicatorView.startAnimating()
        }
    }

    private class func removeSpinner() {
        DispatchQueue.main.async {
            if let loaderView = KEY_WINDOW?.subviews {
                for view in loaderView where view.tag == 500 {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
