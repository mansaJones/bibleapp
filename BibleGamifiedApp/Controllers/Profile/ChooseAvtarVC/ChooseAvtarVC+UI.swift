//
//  ChooseAvtarVC+UI.swift
//  BibleGamifiedApp
//
//  Created by indianic on 23/11/21.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDataSource  UICollectionViewDelegate Method
extension ChooseAvtarVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aAvtarCell: AvtarCell = collectionAvatar.dequeueReusableCell(for: indexPath)
        aAvtarCell.imgAvtar.image = UIImage(named: "ic_avtar" + String(indexPath.row))
        return aAvtarCell
    }
}
