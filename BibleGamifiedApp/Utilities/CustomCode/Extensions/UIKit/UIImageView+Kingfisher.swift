//
//  UIImageView+Kingfisher.swift
//  Unicorn
//
//  Created by Unicorn 12/04/21.
//  Copyright © 2021 Unicorn Ltd. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    /// - Util function to add image with caching
    func setImageUsingKF(path: String? ) {
        let imgPlace = #imageLiteral(resourceName: "ic_user_placeholder")
        ///  ====  Append base media path here
        self.kf.setImage(with: URL(string: path ?? ""), placeholder: imgPlace, options: [.cacheOriginalImage])

    }

}
