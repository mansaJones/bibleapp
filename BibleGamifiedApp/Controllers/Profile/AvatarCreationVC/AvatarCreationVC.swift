//
//  AvatarCreationVC.swift
//  Commissioning
//
//  Created by indianic on 19/08/21.
//  Copyright © 2021 IndiaNIC. All rights reserved.
//

import Foundation
import UIKit

class AvatarCreationVC: BaseVC {
    // MARK: - IBOutlet
    @IBOutlet weak var btnRight: BaseButton!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var btnLeft: BaseButton!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var collAvatarOptions: UICollectionView!
    @IBOutlet weak var imgVwBodyType: UIImageView!
    @IBOutlet weak var imgVwFaceType: UIImageView!
    @IBOutlet weak var imgVwHairType: UIImageView!
    @IBOutlet weak var imgVwEyewear: UIImageView!
    @IBOutlet weak var viewImageHolder: UIView!

    @IBOutlet weak var lblTitleChooseAvtar: GradientLabel!

    // MARK: - Public Properties
    var objVM: AvatarCreationVM = AvatarCreationVM()
    var objProfileVM = ProfileViewModel()
    var completionBlock: (() -> Void)?

    // MARK: - View Controller Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOnViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

    }

    private func configureOnViewDidLoad() {

        self.lblTitleChooseAvtar.font = R.font.magraBold(size: 27)
        self.lblTitleChooseAvtar.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        self.collAvatarOptions.register(cellType: ColAvatarOptionCell.self)
//        setupLeftTitle(R.string.localizable.avatar_creation())
        self.objVM.setUpAvatarProcess { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performStepChange(moveLeft: true)
            switch strongSelf.objVM.selectedGender {
            case .typeMale:
                strongSelf.setSelectedImage(type: .typeFaceStyle, image: strongSelf.objVM.selectedMaleFace.strImageName)
                strongSelf.setSelectedImage(type: .typeHairStyle, image: strongSelf.objVM.selectedMaleHair.strImageName)
                strongSelf.setSelectedImage(type: .typeGlasses, image: strongSelf.objVM.selectedMaleEyewear.strImageName)
            case .typeFemale:
                strongSelf.setSelectedImage(type: .typeFaceStyle, image: strongSelf.objVM.selectedFemaleFace.strImageName)
                strongSelf.setSelectedImage(type: .typeHairStyle, image: strongSelf.objVM.selectedFemaleHair.strImageName)
                strongSelf.setSelectedImage(type: .typeGlasses, image: strongSelf.objVM.selectedFemaleEyewear.strImageName)
            }
            strongSelf.imgVwBodyType.image = UIImage(named: strongSelf.objVM.selectedGender.strImageName)
            strongSelf.imgVwBodyType.tintColor = UIColor(hex: strongSelf.objVM.selectedSkinTone.strColorCode)
        }
    }

    override func unwindToViewController(_: UIStoryboardSegue) {
//        self.dismissVC()
    }

    // MARK: - User Interaction

    @IBAction func btnRightClicked(_ sender: Any) {
        guard let tempStep = (self.objVM.selectedIndex < self.objVM.arrSteps.count) ? self.objVM.arrSteps[self.objVM.selectedIndex] : self.objVM.arrSteps.first else { return }
        if tempStep.isLastStep {
            self.updateAvatarImageAPI()
        } else {
            self.performStepChange(moveLeft: false)
        }
    }

    @IBAction func btnLeftClicked(_ sender: Any) {
        self.performStepChange(moveLeft: true)
    }

    /// performStepChange: Call this method to set perform selection
    /// - Parameter moveLeft: moveLeft
    private func performStepChange(moveLeft: Bool) {
        if moveLeft {
            let tempIndex = (self.objVM.selectedIndex > 0) ? (self.objVM.selectedIndex - 1) : 0
            self.objVM.setSelectedIndex(index: tempIndex)
        } else {
            let tempIndex = (self.objVM.selectedIndex < (self.objVM.arrSteps.count - 1)) ? (self.objVM.selectedIndex + 1) : (self.objVM.arrSteps.count - 1)
            self.objVM.setSelectedIndex(index: tempIndex)
        }
        self.setStepInfo()
    }

    private func setStepInfo() {
        guard let tempStep = (self.objVM.selectedIndex < self.objVM.arrSteps.count) ? self.objVM.arrSteps[self.objVM.selectedIndex] : self.objVM.arrSteps.first else { return }

        let strLeft = R.string.localizable.kPrevious()
        var strRight = ""
        if tempStep.isFirstStep {
            strRight = R.string.localizable.kNext()
        } else {
            strRight = tempStep.isLastStep ? R.string.localizable.kSUBMIT() : R.string.localizable.kNext()
        }

        self.viewAvatar.alpha = 0
        UIView.transition(with: self.viewAvatar, duration: 0.3, options: .transitionCrossDissolve) {

        } completion: { (isCompleted) in
            if isCompleted {
                self.viewAvatar.alpha = 1
                self.btnLeft.setTitle(strLeft, for: .normal)
                self.btnRight.setTitle(strRight, for: .normal)
                self.viewLeft.isHidden = tempStep.isFirstStep

                self.lblTitle.text = tempStep.strTitle.localized
                self.lblDetails.text = tempStep.strSubTitle.localized
                self.lblSteps.text = "\(self.objVM.selectedIndex + 1) / \(self.objVM.arrSteps.count)"
                self.collAvatarOptions.reloadData()
                self.collAvatarOptions.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            }
        }
    }

    private func updateAvatarImageAPI() {
        guard let tempImage = self.viewImageHolder.screenshot else { return }
        objProfileVM.uploadMediaFile(image: tempImage) { [self] _ in
            var objLoginModel: LoginModel?
            if  let user = UserManager.shared.current {
                objLoginModel = user
                objLoginModel?.data?.avatar = self.objProfileVM.objFileUpload?.avatar ?? ""
                UserManager.shared.syncCurrentUser(with: objLoginModel!)
            }
            completionBlock?()
            self.poptoVC()
        }

    }

    private func setSelectedImage(type: AvatarStepType, image: String) {
        var imageCurrent = UIImage(named: image)
        if image == AvatarMaleEyewear.typeEmptyOption.strImageName {
            imageCurrent = nil
        }
        switch type {
        case .typeSkinTone:
            break
        case .typeFaceStyle:
            self.imgVwFaceType.image = imageCurrent
        case .typeHairStyle:
            self.imgVwHairType.image = imageCurrent
        case .typeGlasses:
            self.imgVwEyewear.image = imageCurrent
        }
    }
}

extension AvatarCreationVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.objVM.selectedIndex < self.objVM.arrSteps.count {
            guard let tempStep = (self.objVM.selectedIndex < self.objVM.arrSteps.count) ? self.objVM.arrSteps[self.objVM.selectedIndex] : self.objVM.arrSteps.first else { return 0 }

            switch tempStep.type {
            case .typeSkinTone:
                return self.objVM.arrSkinTones.count
            case .typeFaceStyle:
                return (self.objVM.selectedGender == AppGenderType.typeMale) ? self.objVM.arrMaleFaces.count : self.objVM.arrFemaleFaces.count
            case .typeHairStyle:
                return (self.objVM.selectedGender == AppGenderType.typeMale) ? self.objVM.arrMaleHairs.count : self.objVM.arrFemaleHairs.count
            case .typeGlasses:
                return (self.objVM.selectedGender == AppGenderType.typeMale) ? self.objVM.arrMaleEyewears.count : self.objVM.arrFemaleEyewears.count
            }
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.objVM.selectedIndex < self.objVM.arrSteps.count {
            guard let tempStep = (self.objVM.selectedIndex < self.objVM.arrSteps.count) ? self.objVM.arrSteps[self.objVM.selectedIndex] : self.objVM.arrSteps.first else { return UICollectionViewCell() }
            let cell: ColAvatarOptionCell = collectionView.dequeueReusableCell(for: indexPath, cellType: ColAvatarOptionCell.self)

            switch tempStep.type {
            case .typeSkinTone:
                if indexPath.row < self.objVM.arrSkinTones.count {
                    let currentType = self.objVM.arrSkinTones[indexPath.row]
                    let isSelected = self.objVM.selectedSkinTone == currentType
                    let tempImage = UIImage(color: UIColor(hex: currentType.strColorCode), size: CGSize(width: 60, height: 60))
                    cell.configureCell(imgae: tempImage, isSelected: isSelected)
                }
            case .typeFaceStyle:

                switch self.objVM.selectedGender {
                case .typeMale:
                    if indexPath.row < self.objVM.arrMaleFaces.count {
                        let currentType = self.objVM.arrMaleFaces[indexPath.row]
                        let imageCurrent = UIImage(named: currentType.strThumbImageName)
                        let isSelected = self.objVM.selectedMaleFace == currentType
                        cell.configureCell(imgae: imageCurrent, isSelected: isSelected)
                    }
                case .typeFemale:
                    if indexPath.row < self.objVM.arrFemaleFaces.count {
                        let currentType = self.objVM.arrFemaleFaces[indexPath.row]
                        let imageCurrent = UIImage(named: currentType.strThumbImageName)
                        let isSelected = self.objVM.selectedFemaleFace == currentType
                        cell.configureCell(imgae: imageCurrent, isSelected: isSelected)
                    }
                }
            case .typeHairStyle:
                switch self.objVM.selectedGender {
                case .typeMale:
                    if indexPath.row < self.objVM.arrMaleHairs.count {
                        let currentType = self.objVM.arrMaleHairs[indexPath.row]
                        let imageCurrent = UIImage(named: currentType.strThumbImageName)
                        let isSelected = self.objVM.selectedMaleHair == currentType
                        cell.configureCell(imgae: imageCurrent, isSelected: isSelected)
                    }
                case .typeFemale:
                    if indexPath.row < self.objVM.arrFemaleHairs.count {
                        let currentType = self.objVM.arrFemaleHairs[indexPath.row]
                        let imageCurrent = UIImage(named: currentType.strThumbImageName)
                        let isSelected = self.objVM.selectedFemaleHair == currentType
                        cell.configureCell(imgae: imageCurrent, isSelected: isSelected)
                    }
                }

            case .typeGlasses:
                switch self.objVM.selectedGender {
                case .typeMale:
                    if indexPath.row < self.objVM.arrMaleEyewears.count {
                        let currentType = self.objVM.arrMaleEyewears[indexPath.row]
                        let imageCurrent = UIImage(named: currentType.strThumbImageName)
                        let isSelected = self.objVM.selectedMaleEyewear == currentType
                        cell.configureCell(imgae: imageCurrent, isSelected: isSelected)
                    }
                case .typeFemale:
                    if indexPath.row < self.objVM.arrFemaleEyewears.count {
                        let currentType = self.objVM.arrFemaleEyewears[indexPath.row]
                        let imageCurrent = UIImage(named: currentType.strThumbImageName)
                        let isSelected = self.objVM.selectedFemaleEyewear == currentType
                        cell.configureCell(imgae: imageCurrent, isSelected: isSelected)
                    }
                }
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.objVM.selectedIndex < self.objVM.arrSteps.count {
            guard let tempStep = (self.objVM.selectedIndex < self.objVM.arrSteps.count) ? self.objVM.arrSteps[self.objVM.selectedIndex] : self.objVM.arrSteps.first else { return }
            switch tempStep.type {
            case .typeSkinTone:
                if indexPath.row < self.objVM.arrSkinTones.count {
                    let currentType = self.objVM.arrSkinTones[indexPath.row]
                    self.objVM.setSelectedSkinTone(tone: currentType)
                    self.collAvatarOptions.reloadData()
                    self.imgVwBodyType.tintColor = UIColor(hex: currentType.strColorCode)
                }
            case .typeFaceStyle:
                switch self.objVM.selectedGender {
                case .typeMale:
                    if indexPath.row < self.objVM.arrMaleFaces.count {
                        let currentType = self.objVM.arrMaleFaces[indexPath.row]
                        self.objVM.setSelectedMaleFace(face: currentType)
                        self.collAvatarOptions.reloadData()
                        self.setSelectedImage(type: tempStep.type, image: currentType.strImageName)
                    }
                case .typeFemale:
                    if indexPath.row < self.objVM.arrFemaleFaces.count {
                        let currentType = self.objVM.arrFemaleFaces[indexPath.row]
                        self.objVM.setSelectedFemaleFace(face: currentType)
                        self.collAvatarOptions.reloadData()
                        self.setSelectedImage(type: tempStep.type, image: currentType.strImageName)
                    }
                }
            case .typeHairStyle:
                switch self.objVM.selectedGender {
                case .typeMale:
                    if indexPath.row < self.objVM.arrMaleHairs.count {
                        let currentType = self.objVM.arrMaleHairs[indexPath.row]
                        self.objVM.setSelectedMaleHair(hair: currentType)
                        self.collAvatarOptions.reloadData()
                        self.setSelectedImage(type: tempStep.type, image: currentType.strImageName)
                    }
                case .typeFemale:
                    if indexPath.row < self.objVM.arrFemaleHairs.count {
                        let currentType = self.objVM.arrFemaleHairs[indexPath.row]
                        self.objVM.setSelectedFemaleHair(hair: currentType)
                        self.collAvatarOptions.reloadData()
                        self.setSelectedImage(type: tempStep.type, image: currentType.strImageName)
                    }
                }
            case .typeGlasses:
                switch self.objVM.selectedGender {
                case .typeMale:
                    if indexPath.row < self.objVM.arrMaleEyewears.count {
                        let currentType = self.objVM.arrMaleEyewears[indexPath.row]
                        self.objVM.setSelectedMaleEyewear(wear: currentType)
                        self.collAvatarOptions.reloadData()
                        self.setSelectedImage(type: tempStep.type, image: currentType.strImageName)
                    }
                case .typeFemale:
                    if indexPath.row < self.objVM.arrFemaleEyewears.count {
                        let currentType = self.objVM.arrFemaleEyewears[indexPath.row]
                        self.objVM.setSelectedFemaleEyewear(wear: currentType)
                        self.collAvatarOptions.reloadData()
                        self.setSelectedImage(type: tempStep.type, image: currentType.strImageName)
                    }
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}
