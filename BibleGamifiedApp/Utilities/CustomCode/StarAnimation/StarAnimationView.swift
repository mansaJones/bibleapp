//
//  StarAnimationView.swift
//  StarAnimationView
//
//
//  Created by Naman on 19/11/18.
//  Copyright © 2018 Naman. All rights reserved.
//

import UIKit
import Lottie // pod 'lottie-ios'

/*
 
 StarAnimationView.show()
 StarAnimationView.dismiss()
 
 */

private let APP_DELEGATE_progressView = UIApplication.shared.delegate as! AppDelegate

class StarAnimationViewOptions {
    static var filename: String? {
        didSet {
            StarAnimationView.shared.setNeedsDisplay()
        }
    }
    static var scale: CGFloat = 0.5 {
        didSet {
            let screeWidth = UIScreen.main.bounds.width
            StarAnimationView.shared.frame = CGRect(x: 0, y: 0, width: screeWidth * StarAnimationViewOptions.scale, height: screeWidth * StarAnimationViewOptions.scale)
            StarAnimationView.shared.center = APP_DELEGATE_progressView.window?.center ?? CGPoint.zero
        }
    }
    fileprivate static let viewTag = 7284
}

class StarAnimationView: UIView {
    fileprivate static var progressAnimation: LottieView?
    fileprivate static var shared: StarAnimationView {
        let view = StarAnimationView()
        let screeWidth = UIScreen.main.bounds.width
        view.frame = CGRect(x: 0, y: 0, width: screeWidth * StarAnimationViewOptions.scale, height: screeWidth * StarAnimationViewOptions.scale)
        view.center = APP_DELEGATE_progressView.window?.center ?? CGPoint.zero
        return view
    }

    static func show() {
        print("Show")
        if let StarAnimationView = progressAnimation {
            StarAnimationView.play()

        }
        APP_DELEGATE_progressView.window?.addSubview(shared)
        APP_DELEGATE_progressView.window?.isUserInteractionEnabled = false
    }

    static func dismiss() {
        DispatchQueue.main.async {
//            print("Hide")

            if let progressAnimation = progressAnimation {
                progressAnimation.isHidden = true
                if let p = APP_DELEGATE_progressView.window?.subviews.filter({$0.tag == StarAnimationViewOptions.viewTag}).first {
                    p.removeFromSuperview()
                    APP_DELEGATE_progressView.window?.isUserInteractionEnabled = true
                }
            }

        }
    }

    override func draw(_ rect: CGRect) {
        StarAnimationView.progressAnimation = LOTAnimationView(name: StarAnimationViewOptions.filename ?? "no_connection")
        // Set view to full screen, aspectFill
        StarAnimationView.progressAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        StarAnimationView.progressAnimation!.contentMode = .scaleAspectFill
        StarAnimationView.progressAnimation!.frame = self.bounds
        // Add the Animation
        self.addSubview(StarAnimationView.progressAnimation!)

        StarAnimationView.progressAnimation!.loopAnimation = true
        StarAnimationView.progressAnimation!.play()
        StarAnimationView.progressAnimation!.backgroundColor = .clear

        self.tag = StarAnimationViewOptions.viewTag
    }

}
