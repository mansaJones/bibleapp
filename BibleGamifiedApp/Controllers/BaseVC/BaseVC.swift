//
//  BaseVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 19/11/21.
//

import UIKit

class BaseVC: UIViewController {

    public lazy var itemsCollections = [DataClass]()
    public var items_CollectionView: UICollectionView!
    public var destinationView: UIView!

    private lazy var customImgView = UIImageView()
     var startFrame = CGRect()
    private lazy var isReachedDest = Bool()
    private lazy var isPanRunning = Bool()
    private lazy var isPanAllowed = Bool()
    private var indexPathForItem: IndexPath?
    var destinationMatchBlock: ((Bool) -> Void)?

    func addGesturesForCollectionView() {

        let longPressGest = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGestureAction))
        longPressGest.delegate = self
        longPressGest.minimumPressDuration = 0
        items_CollectionView.addGestureRecognizer(longPressGest)

        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(panGestureAction))
        panGesture.delaysTouchesBegan = true
        panGesture.delegate = self
        items_CollectionView.addGestureRecognizer(panGesture)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }

    // MARK: - ✅ Memory MGT
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - ✅ StatusBar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /// Button Action method for Pop conttoller  Buttonn
    /// - Parameter sender: Object of the Button
    @IBAction func btnPopController(_ sender: Any) {
        if (self is DragDropGameVC) == true || (self is CardMatchingVC) == true {
            
            UIAlertController.showAlert(controller: self, title: R.string.localizable.k_appName(), message: R.string.localizable.kQuitGameMsg(), style: .alert, cancelButton: R.string.localizable.btn_cancel(), distrutiveButton: R.string.localizable.btn_yes(), otherButtons: nil) { (_, btnStr) in
                if btnStr == R.string.localizable.btn_yes() {
                    self.poptoGameUnlockVC()
                }
            }
            
        } else {
            // POP
            let firstVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count ?? 2) - 2] as? MainDashboardVC
            if let firstView = firstVC?.view {
                self.navigationController?.popViewController(animated: false)
                UIView.transition(from: self.view, to: firstView, duration: 0.85, options: [.transitionFlipFromRight])
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    /// Button Action method for Pop conttoller  Buttonn
    /// - Parameter sender: Object of the Button
    @IBAction func btnDismissVCTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension BaseVC: UIGestureRecognizerDelegate {

    // MARK: - Gesture Delegate Methods
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc fileprivate func panGestureAction (_ gestureRecognizer: UIPanGestureRecognizer) {

        if !isPanAllowed || !customImgView.isDescendant(of: self.view) {
            items_CollectionView.isScrollEnabled = true
            return
        }

        let translation = gestureRecognizer.translation(in: self.view)
        items_CollectionView.isScrollEnabled = false

        if gestureRecognizer.state == .began {
            startFrame = customImgView.frame
        } else if gestureRecognizer.state == .changed {

            checkWhetherProductMovedDestination()
            customImgView.center = CGPoint(x: customImgView.center.x + translation.x, y: customImgView.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)

        } else if gestureRecognizer.state == .ended {
            self.view.isUserInteractionEnabled = false
            Utility.delay((0)) {
                self.view.isUserInteractionEnabled = true
                self.destinationMatchBlock?(self.isReachedDest)
            }
            self.caseMethodForPanCompletionWith(gestureRecognizer)

        }
    }

    private func caseMethodForPanCompletionWith(_ gestureRecognizer: UIPanGestureRecognizer) {

        if indexPathForItem == nil || !customImgView.isDescendant(of: self.view) {
            return
        }

        let velocity = gestureRecognizer.velocity(in: self.view)

        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        let slideMultiplier = magnitude / 200
        // print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")

        let slideFactor = 0.1 * slideMultiplier     // Increase for more of a slide

        var finalPoint = CGPoint(x: customImgView.center.x + (velocity.x * slideFactor),
                                 y: customImgView.center.y + (velocity.y * slideFactor))
        finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
        finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        self?.customImgView.center = finalPoint
                        self?.checkWhetherProductMovedDestination()
            },
                       completion: { [weak self] _ in

                        self?.panCompletionMethod()
        })
        items_CollectionView.isScrollEnabled = true
    }

    fileprivate func panCompletionMethod() {

        if self.isReachedDest {
            UIView.animate(withDuration: 0.2, animations: { [weak weakSelf = self] in
                let destionViewCenterWithRespectMain = weakSelf?.getTheMainViewBasedCenterForDestination()
                weakSelf?.customImgView.frame = CGRect(x: (destionViewCenterWithRespectMain?.x)! - 5, y: (destionViewCenterWithRespectMain?.y)! - 5, width: 10.0, height: 10.0)
                }, completion: {  [weak weakSelf = self] _ in

                    weakSelf?.doSomeThingsAfterPanCompletion()})
        } else {
            UIView.animate(withDuration: 0.2, animations: { [weak weakSelf = self] in
                weakSelf?.customImgView.frame = (weakSelf?.constructFrameForIndex(indexPath: (weakSelf?.indexPathForItem)!))!
                }, completion: {  [weak weakSelf = self] _ in
                    weakSelf?.doSomeThingsAfterPanCompletion()})
        }

    }

    fileprivate func checkWhetherProductMovedDestination() {
        isPanRunning = true

        isReachedDest = false

        if destinationView.frame.intersects(customImgView.frame) {
            // handle overlap
            isReachedDest = true
        }

    }

    fileprivate func getTheMainViewBasedCenterForDestination() -> CGPoint {
        var destionViewCenterWithRespectMain = destinationView.center

        if var destinationSuperView = destinationView.superview {
            destionViewCenterWithRespectMain = CGPoint(x: destionViewCenterWithRespectMain.x + destinationSuperView.frame.origin.x, y: destionViewCenterWithRespectMain.y + destinationSuperView.frame.origin.y)
            while let anotherSuperView = destinationSuperView.superview {
                destionViewCenterWithRespectMain = CGPoint(x: destionViewCenterWithRespectMain.x + anotherSuperView.frame.origin.x, y: destionViewCenterWithRespectMain.y + anotherSuperView.frame.origin.y)
                destinationSuperView = anotherSuperView
            }
        }
        return destionViewCenterWithRespectMain
    }

    @objc fileprivate func longPressGestureAction(_ gestureRecognizer: UILongPressGestureRecognizer) {

        if isPanRunning {
            return
        }

        if gestureRecognizer.state == .began {

            let point = gestureRecognizer.location(in: items_CollectionView)

            guard let indexPathToCheck = items_CollectionView.indexPathForItem(at: point) else {
                return
            }
            if customImgView.isDescendant(of: self.view) {
                customImgView.removeFromSuperview()
            }
            isPanAllowed = true

            print("IndexPath : \(indexPathToCheck)")
            addCustomViewAt(point)
        } else if gestureRecognizer.state == .ended {

            isPanAllowed = false

            if customImgView.isDescendant(of: view) {
                customImgView.removeFromSuperview()
            }
            items_CollectionView.isScrollEnabled = true
        }
    }

    fileprivate func addCustomViewAt(_ point: CGPoint) {

        guard let indexPath = items_CollectionView.indexPathForItem(at: point) else {return}

        if customImgView.isDescendant(of: self.view) {
            print("Nil Indexpath or already view available>>>>>>> Returned")
            return
        }

        indexPathForItem = indexPath as IndexPath
        customImgView = UIImageView.init(frame: constructFrameForIndex(indexPath: indexPath))
        customImgView.contentMode = .scaleAspectFit

        let itemAtIndexPath = itemsCollections[(indexPath.row)]
        customImgView.image = UIImage.init(named: itemAtIndexPath.imageName)
        customImgView.backgroundColor = UIColor.clear

        startFrame = customImgView.frame
        self.view.addSubview(customImgView)
    }

    // MARK: - All The Gesture Methods

     func doSomeThingsAfterPanCompletion() {

        if customImgView.isDescendant(of: view) {
            customImgView.removeFromSuperview()
        }
        isReachedDest = false
        isPanRunning = false
        isPanAllowed = false
    }

    fileprivate func constructFrameForIndex(indexPath: IndexPath) -> CGRect {

        let attributes = items_CollectionView.layoutAttributesForItem(at: indexPath as IndexPath)
        let sizeRect = attributes?.frame
//        let tempView = UIView.init(frame: CGRect(x: 0, y: 0, width: 80 + 0, height: 80))

        let tempView = UIView.init(frame: CGRect(x: 0, y: 0, width: (sizeRect?.size.width)! - 30, height: (sizeRect?.size.height)! - 30))
        tempView.center = CGPoint(x: (attributes?.center.x)! + items_CollectionView.frame.origin.x - items_CollectionView.contentOffset.x, y: (attributes?.center.y)! + items_CollectionView.frame.origin.y - items_CollectionView.contentOffset.y)

        if var theSuperView = items_CollectionView.superview {
            tempView.center = CGPoint(x: tempView.center.x + theSuperView.frame.origin.x, y: tempView.center.y + theSuperView.frame.origin.y)
            while let anotherSuperView = theSuperView.superview {
                tempView.center = CGPoint(x: tempView.center.x + anotherSuperView.frame.origin.x, y: tempView.center.y + anotherSuperView.frame.origin.y)
                theSuperView = anotherSuperView
            }
        }

        return tempView.frame
    }
}
