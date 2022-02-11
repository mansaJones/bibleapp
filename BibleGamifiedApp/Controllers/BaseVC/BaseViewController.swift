//
//  BaseViewController.swift
//  GoodwillChoice
//
//  Created by IndianNIC on 01/05/20.
//  Copyright © 2020 IndiaNIC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - View Controller Methods
    var headerColor: UIColor = UIColor.app.navBarBG

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationOnViewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Dismiss Keyboard when navigate the View Controller
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setNeedsStatusBarAppearanceUpdate()
        self.statusBarColorChange(color: self.headerColor)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Memory Management Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        Logger.log("deinit")
        print("~~~~~ deinit: \(self) ~~~~~")
    }

    private func setConfigurationOnViewDidLoad() {
        // Hide Keyboard when tap anywhere in view
        hideKeyboardWhenTappedAround()
//        navigationController?.navigationBar.isTranslucent = true

//        navigationController?.navigationBar.setColors(background: UIColor.app.lightPurple , text: UIColor.app.white)
        navigationController?.navigationBar.setColors(background: UIColor.app.navBarBG, text: UIColor.app.white)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = .default
        navigationItem.title = navigationItem.title?.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: R.font.magra(size: 17.0)!]
        enableInreractivePopGesture = true
    }

    public func setupLeftTitle(_ title: String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 240, height: 30))
        view.backgroundColor = .clear
        let labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 30))
        labelTitle.font = R.font.magra(size: 17.0)
        labelTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        labelTitle.text = title
        view.addSubview(labelTitle)
        if let leftBarButtonItems = self.navigationItem.leftBarButtonItems {
            var mutLeftBarButtonItems = leftBarButtonItems
            mutLeftBarButtonItems.append(UIBarButtonItem(customView: view))
            self.navigationItem.leftBarButtonItems = mutLeftBarButtonItems
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
        }
    }

    // MARK: - StatusBar Setup

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    // MARK: - Button Action Methods

    /// Button Action method for Register
    /// - Parameter sender: Object of the Button
    @IBAction func didTapOnCloseButton(_: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }

    @objc func actionBack(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.performUIUpdateBasedOnOrientaion()
    }

    /// performUIUpdateBasedOnOrientaion: Call this method to perform UI update based on orientation change
    func performUIUpdateBasedOnOrientaion() {

    }
}

extension UIViewController {
    @IBAction func unwindToViewController(_: UIStoryboardSegue) {}

    func statusBarColorChange(color: UIColor) {
      if #available(iOS 13.0, *) {
          let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
          statusBar.backgroundColor = color
              statusBar.tag = 100
          UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
      } else {
              let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
              statusBar?.backgroundColor = color
          }
      }
}
