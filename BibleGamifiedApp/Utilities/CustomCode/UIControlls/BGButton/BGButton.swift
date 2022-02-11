//
//  BGButton.swift
//  BibleGamifiedApp
//
//  Created by indianic on 09/12/21.
//

import UIKit

class BGButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        // TODO: Code for our button with underline
        self.setUnderLineButtonWith(font: R.font.magraBold(size: 20)!)
    }

}
extension UIButton {
    func setUnderLineButtonWith(font: UIFont, underlineNeeded: Bool = true) {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))

        if underlineNeeded {
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        }
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
