//
//  ReferFriendVC.swift
//  BibleGamifiedApp
//
//  Created by indianic on 17/12/21.
//

import UIKit
import FirebaseDynamicLinks

class ReferFriendVC: BaseVC {

    @IBOutlet weak var lblTitle: GradientLabel!
    @IBOutlet weak var lblRefalCode: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        self.handleTrasperentNavigation()
    }

    func handleTrasperentNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.standardAppearance.backgroundEffect = nil
        self.navigationController?.navigationBar.standardAppearance.shadowImage = UIImage()
        self.navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance.backgroundImage = UIImage()
    }

    @IBAction func btnInviteReferCodeAction(_ sender: UIButton) {
        if let user = UserManager.shared.current?.data {
            self.createDynamicLink(fromVC: self, linkSuffix: "/biblegamifiedapp", title: R.string.localizable.k_appName(), desc: R.string.localizable.k_appName(), imgUrl: "", referCode: user.referralCode ?? "", eventType: "", arrContactNo: [""], eventDate: "", eventTime: "")
        }
    }

    @IBAction func btnReferCodeAction(_ sender: UIButton) {
        // write to clipboard
        if let user = UserManager.shared.current?.data, let referralCode = user.referralCode, !referralCode.isEmpty {
            UIPasteboard.general.string = referralCode
            AlertMesage.show(.info, message: R.string.localizable.kRefralCodeCopyClipbardMSG())
        }
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        self.lblTitle.font = R.font.magraBold(size: 27)
        self.lblTitle.gradientColors = [R.color.a4C1A00()!.cgColor, R.color.a994209()!.cgColor]

        if let user = UserManager.shared.current?.data {
            lblRefalCode.text = user.referralCode ?? ""
        }
    }
}

extension ReferFriendVC {

    // MARK: - Firebase Dynamic Link
    public func createDynamicLink(fromVC: UIViewController, linkSuffix: String, title: String? = "", desc: String? = "", imgUrl: String? = "", referCode: String? = "", eventType: String? = "", arrContactNo: [String]? = [""], eventDate: String? = "", eventTime: String? = "") {

        var components  = URLComponents()
        components.scheme = "https"
        components.host = "biblegamifiedapplication.page.link"
        components.path = "/refralcode"

        let eventIDQueryItem = URLQueryItem(name: "refercode", value: referCode)
        components.queryItems = [eventIDQueryItem]

        guard let linkParameters = components.url else { return }
        //        print("I'm sharing \(linkParameters.absoluteString)")

        let dynamicLinksDomainURIPrefix = API.URL.firebaseDomainURIPrefix
        guard let linkBuilder = DynamicLinkComponents(link: linkParameters, domainURIPrefix: dynamicLinksDomainURIPrefix) else { return }

        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: Constant.BUNDLEID)
        linkBuilder.iOSParameters?.appStoreID = Constant.AppStoreID

        // iOS params
        let iOSParams = DynamicLinkIOSParameters(bundleID: Constant.BUNDLEID)
        iOSParams.fallbackURL = URL(string: "Fallback URL")
        iOSParams.minimumAppVersion = "13.0"
        iOSParams.customScheme = "Custom Scheme"
//        iOSParams.appStoreID = Constant.AppStoreID
        linkBuilder.iOSParameters = iOSParams

        // iTunesConnect params
        let appStoreParams = DynamicLinkItunesConnectAnalyticsParameters()
        appStoreParams.affiliateToken = "Affiliate Token"
        appStoreParams.campaignToken = "Campaign Token"
        appStoreParams.providerToken = "Provider Token"
        linkBuilder.iTunesConnectParameters = appStoreParams

        linkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder.socialMetaTagParameters?.title = title

        let aEventAppStoreLink = R.string.localizable.kiOSAppStoreLink() + " : " + Constant.kBibleGamifiedAppStoreLink ?? ""

        var eventDescription = desc!
        eventDescription += "\n" + aEventAppStoreLink

        print("eventDescription = \(eventDescription)")

        linkBuilder.socialMetaTagParameters?.descriptionText = eventDescription

        if let aImgUrl = imgUrl {
            linkBuilder.socialMetaTagParameters?.imageURL = URL(string: aImgUrl)
        }

        guard let longDynamicLink = linkBuilder.url else { return }
        //        print("The long URL is: \(longDynamicLink)")

        // [START shortLinkOptions]
        let options = DynamicLinkComponentsOptions()
        options.pathLength = .unguessable
        linkBuilder.options = options
        // [END shortLinkOptions]

        // [START shortenLink]
        linkBuilder.shorten { shortURL, _, error in
            // Handle shortURL.
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(shortURL?.absoluteString ?? "")
            // [START_EXCLUDE]

            guard let url = shortURL, error == nil else { return }
            //          print("The short URL is: \(url)")

            let items = [url] as [Any]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            fromVC.present(ac, animated: true)

            // [END_EXCLUDE]
        }

        //        DynamicLinkComponents.shortenURL(longDynamicLink, options: nil) { url, _, error in
        //            guard let url = url, error == nil else { return }
        //            //          print("The short URL is: \(url)")
        //
        //            let items = [url] as [Any]
        //            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        //            fromVC.present(ac, animated: true)
        //        }

    }
}
