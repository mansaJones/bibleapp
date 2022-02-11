//
//  ChooseAvtarVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 22/11/21.
//

import UIKit
/// ChooseAvtarVC controller allow user to choose custom avtar for profile

class ChooseAvtarVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var lblTitleChooseAvtar: GradientLabel!
    @IBOutlet weak var collectionAvatar: UICollectionView!

    // MARK: Variable

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()

    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {

        self.lblTitleChooseAvtar.font = R.font.magraBold(size: 27)
        self.lblTitleChooseAvtar.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]
        collectionAvatar.register(cellType: AvtarCell.self)
        Utility.delay(0) {
            Utility.setupCollectionUi(collection: self.collectionAvatar, cellHeight: 212)
        }
        self.collectionAvatar.contentInset = UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 0)
        collectionAvatar.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

    }

    // MARK: Actions

    // MARK: Private Methods
}
