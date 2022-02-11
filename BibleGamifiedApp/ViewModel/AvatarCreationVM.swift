//
//  AvatarCreationVM.swift
//  Commissioning
//
//  Created by indianic on 19/08/21.
//  Copyright © 2021 IndiaNIC. All rights reserved.
//

import Foundation
import UIKit

class AvatarCreationVM: NSObject {
    public private(set) var arrSteps: [AvatarSteps] = []
    public private(set) var selectedIndex: Int = 0
    public private(set) var arrMaleFaces: [AvatarMaleFace] = []
    public private(set) var arrMaleHairs: [AvatarMaleHairStyle] = []
    public private(set) var arrMaleEyewears: [AvatarMaleEyewear] = []
    public private(set) var arrFemaleFaces: [AvatarFemaleFace] = []
    public private(set) var arrFemaleHairs: [AvatarFemaleHairStyle] = []
    public private(set) var arrFemaleEyewears: [AvatarFemaleEyewear] = []
    public private(set) var arrSkinTones: [AvatarSkinTone] = []
    public private(set) var selectedMaleFace: AvatarMaleFace = .typeMaleFace1
    public private(set) var selectedMaleHair: AvatarMaleHairStyle = .typeMaleHair1
    public private(set) var selectedMaleEyewear: AvatarMaleEyewear = .typeMaleEyewear1
    public private(set) var selectedFemaleFace: AvatarFemaleFace = .typeFemaleFace1
    public private(set) var selectedFemaleHair: AvatarFemaleHairStyle = .typeFemaleHair1
    public private(set) var selectedFemaleEyewear: AvatarFemaleEyewear = .typeFemaleEyewear1
    public private(set) var selectedSkinTone: AvatarSkinTone = .typeTone1
    public private(set) var selectedGender: AppGenderType = .typeMale

    /// setSelectedIndex: Call this method to set selected
    /// - Parameter index: index
    func setSelectedIndex(index: Int) {
        self.selectedIndex = index
    }

    /// setSelectedMaleFace: call this method to set SelectedMaleFace
    /// - Parameter face: face
    func setSelectedMaleFace(face: AvatarMaleFace) {
        self.selectedMaleFace = face
    }

    /// setSelectedMaleHair: call this method to set SelectedMaleHair
    /// - Parameter hair: hair
    func setSelectedMaleHair(hair: AvatarMaleHairStyle) {
        self.selectedMaleHair = hair
    }

    /// setSelectedMaleEyewear: call this method to set SelectedMaleEyewear
    /// - Parameter wear: wear
    func setSelectedMaleEyewear(wear: AvatarMaleEyewear) {
        self.selectedMaleEyewear = wear
    }

    /// setSelectedFemaleFace: call this method to set setSelectedFemaleFace
    /// - Parameter face: face
    func setSelectedFemaleFace(face: AvatarFemaleFace) {
        self.selectedFemaleFace = face
    }

    /// setSelectedFemaleHair: call this method to set SelectedFemaleHair
    /// - Parameter hair: hair
    func setSelectedFemaleHair(hair: AvatarFemaleHairStyle) {
        self.selectedFemaleHair = hair
    }

    /// setSelectedFemaleEyewear: call this method to set setSelectedFemaleEyewear
    /// - Parameter wear: wear
    func setSelectedFemaleEyewear(wear: AvatarFemaleEyewear) {
        self.selectedFemaleEyewear = wear
    }

    /// setSelectedSkinTone: call this method to set SelectedSkinTone
    /// - Parameter tone: tone
    func setSelectedSkinTone(tone: AvatarSkinTone) {
        self.selectedSkinTone = tone
    }

    /// setUpAvatarProcess: Call this method to setup avatar steps creation process
    func setUpAvatarProcess(completion: (() -> Void)) {
        self.arrSteps = []
        self.arrMaleFaces = []
        self.arrMaleHairs = []
        self.arrMaleEyewears = []
        self.arrFemaleFaces = []
        self.arrFemaleHairs = []
        self.arrFemaleEyewears = []
        self.selectedIndex = 0
        self.selectedMaleFace = .typeMaleFace1
        self.selectedMaleHair = .typeMaleHair1
        self.selectedMaleEyewear = .typeEmptyOption
        self.selectedFemaleFace = .typeFemaleFace1
        self.selectedFemaleHair = .typeFemaleHair1
        self.selectedFemaleEyewear = .typeEmptyOption
        self.selectedSkinTone = .typeTone1
        self.arrMaleFaces = AvatarMaleFace.typeMaleFace1.getMaleFaces()
        self.arrMaleHairs = AvatarMaleHairStyle.typeMaleHair1.getMaleHairStyles()
        self.arrMaleEyewears = AvatarMaleEyewear.typeEmptyOption.getMaleEyewears()

        self.arrFemaleFaces = AvatarFemaleFace.typeFemaleFace1.getFemaleFaces()
        self.arrFemaleHairs = AvatarFemaleHairStyle.typeFemaleHair1.getFemaleHairStyles()
        self.arrFemaleEyewears = AvatarFemaleEyewear.typeEmptyOption.getFemaleEyewears()
        self.arrSkinTones = AvatarSkinTone.typeTone1.getSkinTones()

        self.selectedGender = AppGenderType(strValue: R.string.localizable.kmale())

        let stepOne: AvatarSteps = AvatarSteps(strTitle: R.string.localizable.kSetupAvatar(), strSubTitle: R.string.localizable.kSelectSkinTone(), isFirstStep: true, isLastStep: false, type: .typeSkinTone)
        let stepTwo: AvatarSteps = AvatarSteps(strTitle: R.string.localizable.kSetupAvatar(), strSubTitle: R.string.localizable.kSelectFaceType(), isFirstStep: false, isLastStep: false, type: .typeFaceStyle)
        let stepThree: AvatarSteps = AvatarSteps(strTitle: R.string.localizable.kSetupAvatar(), strSubTitle: R.string.localizable.kSelectHairStyle(), isFirstStep: false, isLastStep: false, type: .typeHairStyle)
        let stepFour: AvatarSteps = AvatarSteps(strTitle: R.string.localizable.kSetupAvatar(), strSubTitle: R.string.localizable.kSelectGlasses(), isFirstStep: false, isLastStep: true, type: .typeGlasses)

        self.arrSteps.append(stepOne)
        self.arrSteps.append(stepTwo)
        self.arrSteps.append(stepThree)
        self.arrSteps.append(stepFour)
        completion()
    }

}
