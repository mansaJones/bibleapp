//
//  ProgressView.swift
//  BibleGamifiedApp
//
//  Created by indianic on 22/11/21.
//

import Foundation
import UIKit

class ProgressView: UIView, NibOwnerLoadable {

    @IBOutlet weak var progressContant: NSLayoutConstraint!

    var counter: Float = Utility.shared.totalGameDuration
    var timer: Timer?
    var totaHeight: Float = 0
    var timerBlock: (ActionType, String) -> Void = { _, _  in }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        initialSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()

        initialSetup()
    }
    private func initialSetup() {

        // schedule timer
        scheduleTimer()
    }

    // MARK: - Timer Methods

    func scheduleTimer() {
        timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    }

    @objc func timerElapsed() {
        counter -= 1
        /// here consider view widht 85 /  total time of game so suuupet to 85/25 = 3.4 so we need to plus 3.5 in every time in timer
        let increseHeight = 85 / Utility.shared.totalGameDuration
        totaHeight += increseHeight
        _ = Int(counter) / 3600
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60

        if self.totaHeight <= 87 {
                self.progressContant.constant =  CGFloat(self.totaHeight)
        }
            UIView.animate(withDuration: 1.3) {
                self.layoutIfNeeded()
            }

       let totalTime = String(format: "%02d:%02d", minutes, seconds)
        timerBlock(ActionType.timeStart, totalTime)
       if counter <= 0 {
        // Stop when timer reaches 0
        timer?.invalidate()
           timerBlock(ActionType.timeEnd, "")
       }
    }

    func timerInvalid() {
        timer?.invalidate()
    }
}
extension ProgressView {

    func getGameStarCount() -> Int {

        let starCount = Int((Float(self.counter * 3) / Utility.shared.totalGameDuration).rounded(.up))
        print("starCount = \(starCount)")
        return starCount
    }
}
