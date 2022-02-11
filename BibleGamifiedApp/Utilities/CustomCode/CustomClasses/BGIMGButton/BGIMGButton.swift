//
//  Created by Unicorn
//  Copyright © Unicorn All rights reserved.
//  Created on 04/02/21

import Foundation
import UIKit
// import MKToolTip

class BGIMGButton: UIButton {

    @IBInspectable var enableClick: Bool = true {
        didSet {
            setupUI()
        }
    }
    /// Set the name of the image which will be used as a Right Image.
    @IBInspectable var leftImage: String? {
        didSet {
            addLeftIcon(image: leftImage)
        }
    }
    // Change Style with Background Border, set by default clear
    @IBInspectable var buttonBackgroundColor: UIColor =  UIColor.blue {
        didSet {
            setupUI()
        }
    }
    @IBInspectable var buttonTextolor: UIColor =  UIColor.white {
        didSet {
            setupUI()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = 12
        backgroundColor = buttonBackgroundColor
        self.isEnabled =  enableClick
        setTitleColor(buttonTextolor, for: .normal)
        titleLabel?.font = R.font.magraBold(size: 15)
        if let aStrTitle = title(for: .normal)?.localized {
            if title(for: .normal)! != aStrTitle {
//                setTitle(aStrTitle.uppercased(), for: .normal)
                setTitle(aStrTitle, for: .normal)
                titleLabel?.adjustsFontSizeToFitWidth = true
            } else {
                return
            }
        }
    }
}

class BaseNormalButton: UIButton {

    @IBInspectable var isBold: Bool = false {
        didSet {
            setupUI()
        }
    }
    @IBInspectable var isSemibold: Bool = false {
        didSet {
            setupUI()
        }
    }

    @IBInspectable var isSemiboldLarge: Bool = false {
        didSet {
            setupUI()
        }
    }
    @IBInspectable var regularTitle: Bool = false {
        didSet {
            setupUI()
        }
    }

    @IBInspectable var cornerRounded: CGFloat = 8 {
        didSet {
            setupUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        titleLabel?.font =  R.font.magraBold(size: 15)
        if isSemibold {
            titleLabel?.font = R.font.magraBold(size: 15)
        }
        if isSemiboldLarge {
            titleLabel?.font = R.font.magraBold(size: 15)
        }
        if regularTitle {
            titleLabel?.font = R.font.magra(size: 15)
        }

        layer.cornerRadius = cornerRounded

        if let aStrTitle = title(for: .normal)?.localized {
            if title(for: .normal)! != aStrTitle {
                setTitle(aStrTitle, for: .normal)
                titleLabel?.adjustsFontSizeToFitWidth = true
            } else {
                return
            }

        }
    }
}
class BaseSmallButton: UIButton {

    @IBInspectable var cornerRounded: CGFloat = 8 {
        didSet {
            setupUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        titleLabel?.font =  R.font.magraBold(size: 15)
        layer.cornerRadius = cornerRounded
        self.imageView?.contentMode = .center
        if let aStrTitle = title(for: .normal)?.localized {
            if title(for: .normal)! != aStrTitle {
                setTitle(aStrTitle, for: .normal)
                titleLabel?.adjustsFontSizeToFitWidth = true
            } else {
                return
            }

        }
    }
}

// MARK: - Add Right Image
extension UIButton {

    func addLeftIcon(image: String?) {
        guard let anImage = image?.trimmed else { return }
        addLeftIcon(image: UIImage(named: anImage))
    }

    func addLeftIcon(image: UIImage?) {

        guard let anImage = image else { return }

        let imageView = UIImageView(image: anImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        let length = CGFloat(16)
        titleEdgeInsets.left += length

//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: 10),
//            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
//            imageView.widthAnchor.constraint(equalToConstant: length),
//            imageView.heightAnchor.constraint(equalToConstant: length)
//        ])

        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.titleLabel!.leadingAnchor, constant: -10),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0)
        ])

    }

}
