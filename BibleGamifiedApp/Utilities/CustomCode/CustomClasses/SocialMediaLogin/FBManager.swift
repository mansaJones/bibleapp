//
//  Facebook.swift
//  BibleGamifiedApp
//
//  Created by indianic on 26/08/20.
//  Copyright © 2020 IndiaNIC Infotech Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin

// import SVProgressHUD

typealias FJFacebookCompletionHandler = (_ obj: Any?, _ success: Bool) -> Void

class FBManager: NSObject {

    //    static let sharedInstance = NRFacebook()
    typealias CompletionHandler = (_ user: Any?, _ error: Error?, _ success: Bool) -> Void

    /// Shared object of the FJFacebook class
    static let shared: FBManager = FBManager()

    private override init() {

        super.init()

    }

    deinit {
        Logger.log("deinit")
    }

    // MARK: FJFacebook LOGIN
    /// Login From facebook API with Read Permission
    /// - Parameter no parameters required
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJLoginWithReadFacebook(_ completionHandler:@escaping CompletionHandler) {
        self.logOut { (_, _) in

        }
        if AccessToken.current == nil {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, error, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, error, false)
                } else {
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")

                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            completionHandler(nil, error, false)
                            return
                        }
                        completionHandler(authResult?.user, nil, true)
                    }
                }
            })

        } else {
            completionHandler(nil, nil, false)
        }
    }

    /// Login From facebook API with Publish Permission
    /// - Parameter no parameters required
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJLoginWithPublishFacebook(_ completionHandler:@escaping FJFacebookCompletionHandler) {
        if AccessToken.current == nil {

            loginWithPublishPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    completionHandler(result, true)
                }
            })

        } else {
            completionHandler(nil, true)
        }
    }

    // MARK: FJFacebook LOGOUT
    /// Logout From facebook
    /// - Parameter no parameters required
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func logOut(_ completionHandler: FJFacebookCompletionHandler) {
        let loginManager: LoginManager = LoginManager()
        if AccessToken.current != nil {
            loginManager.logOut()
        }
        completionHandler(nil, true)
    }

    // MARK: FJFacebook USER INFO
    /// Get User's Information
    /// pass dictionary in format of [String : String]
    ///
    /// ex:- ["fields": "id, name, email, last_name, first_name"]
    /// - Parameter Parameters require as per given above example
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func userData(_ params: [String: String]?, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in
//            ProgressHUD.show()
            self.graphAPIWithGraphPath(graphPath: "me", params: params, completionHandler: { (_, user, error) in
//                ProgressHUD.hide()
                if let aUser = user as? [String: Any] {
                    let objUser = SocialUser(facebookUser: aUser)
                    completionHandler(objUser, true)
                } else {
                    completionHandler(error, false)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    // MARK: FJFacebook USER'S TAGGED FRIEND
    /// Get User's Tagged Friend List
    /// pass dictionary in format of [String : String]
    ///
    /// ex:- ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
    /// - Parameter Parameters require as per given above example
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookTaggedFriend(_ params: [String: String]?, completionHandler:@escaping FJFacebookCompletionHandler) {

        let sendRequestBlock = {() -> Void in

            self.graphAPIWithGraphPath(graphPath: "me/taggable_friends", params: params, completionHandler: { (_, result, error) in
                if error != nil {
                    completionHandler(error as AnyObject, false)
                } else {
                    completionHandler(result as AnyObject, true)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    // MARK: FJFacebook USER'S APP RELATED FRIENDS
    /// Get User's Friend List who are using the same app
    /// pass dictionary in format of [String : String]
    ///
    /// ex:- ["fields": "picture,id,name"]
    /// - Parameter Parameters require as per given above example
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookAppFriend(_ params: [String: String]?, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in

            self.graphAPIWithGraphPath(graphPath: "me/friends", params: params, completionHandler: { (_, result, error) in
                if error != nil {
                    completionHandler(error as AnyObject, false)
                } else {
                    completionHandler(result as AnyObject, true)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    // MARK: FJFacebook GET ALL ALBUMES
    /// Get User's Album
    /// It will provide you first 25 Album name
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookAlbums(_ completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in

            self.graphAPIWithGraphPath(graphPath: "/me/albums", params: ["fields": "id,name,created_time"], completionHandler: { (_, result, error) in
                if error != nil {
                    completionHandler(error as AnyObject, false)
                } else {
                    completionHandler(result as AnyObject, true)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    print(result as Any)
                    sendRequestBlock()
                }
            })
        }
    }

    /// Get User Album's next page
    /// It will provide next 25 Album name
    /// - Parameter strPage: Pass 'after' id from Paging-->cursors of previous Graph API call of album api. (ex- MTM4NjIxMzk1ODI3MDM1NQZDZD)
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookAlbumsNextPage(_ strPage: String, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in
            // let params = []
            // "/\(strPage)/albums"
            self.graphAPIWithGraphPath(graphPath: "/me/albums?after=\(strPage)", params: ["fields": "id,name,created_time"], completionHandler: { (_, result, error) in
                if error != nil {
                    completionHandler(error as AnyObject, false)
                } else {
                    completionHandler(result as AnyObject, true)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    // MARK: FJFacebook GET ALBUM'S PHOTOS
    /// Get Photos of Album
    /// It will provide you first 25 Photos of a particular Album
    /// - Parameter albumID: Pass Album ID for get Photos of that particular Album
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookAlbumsPhotos(_ albumID: String, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in
            // let params = []
            if AccessToken.current?.hasGranted(permission: "user_photos") ?? false {

                self.graphAPIWithGraphPath(graphPath: "\(albumID)/photos", params: ["fields": "id, source"], completionHandler: { (_, result, error) in
                    if error != nil {
                        completionHandler(error as AnyObject, false)
                    } else {
                        completionHandler(result as AnyObject, true)
                    }
                })
            } else {
                print("")
            }
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    /// Get more Photos of Album
    /// It will provide you Next 25 Photos of a particular Album
    /// - Parameter albumID: Pass Album ID for get Photos of that particular Album
    /// - Parameter strPage: Pass 'after' id from Paging-->cursors of previous Graph API call of Photos api. (ex- MTM4NjIxMzk1ODI3MDM1NQZDZD)
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookAlbumsPhotosNextPage(_ albumID: String, strPage: String, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in
            // let params = []
            // "/\(strPage)/albums"
            self.graphAPIWithGraphPath(graphPath: "\(albumID)/photos?after=\(strPage)", params: ["fields": "id, source"], completionHandler: { (_, result, error) in
                if error != nil {
                    completionHandler(error as AnyObject, false)
                } else {
                    completionHandler(result as AnyObject, true)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    // MARK: FJFacebook GET ALL VIDEOS
    /// Get User's Videos
    /// It will provide you first 25 Videos name
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookVideos(_ completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in
            // let params = []
            if AccessToken.current?.hasGranted(permission: "user_videos") ?? false {
                self.graphAPIWithGraphPath(graphPath: "/me/videos/uploaded", params: ["fields": "id, description, updated_time, picture"], completionHandler: { (_, result, error) in
                    if error != nil {
                        completionHandler(error as AnyObject, false)
                    } else {
                        completionHandler(result as AnyObject, true)
                    }
                })
            } else {
                print("SOgetFacebookVideos -----> User has no granted Videos Permission.")
            }
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    /// Get User Video's next page
    /// It will provide next 25 Videos name
    /// - Parameter strPage: Pass 'after' id from Paging-->cursors of previous Graph API call of album api. (ex- MTM4NjIxMzk1ODI3MDM1NQZDZD)
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)
    func FJgetFacebookVideosNextPage(_ strPage: String, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestBlock = {() -> Void in
            // let params = []
            // "/\(strPage)/albums"
            self.graphAPIWithGraphPath(graphPath: "/me/videos/uploaded?after=\(strPage)", params: ["fields": "id, description, updated_time"], completionHandler: { (_, result, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    completionHandler(error as AnyObject, false)
                } else {
                    completionHandler(result as AnyObject, true)
                }
            })
        }

        if AccessToken.current != nil {
            sendRequestBlock()
        } else {
            loginWithReadPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestBlock()
                }
            })
        }
    }

    // MARK: FJFacebook POST IMAGE OR TEXT
    /// Post Image and text on facebook
    /// - Parameter txtMessage: Message you want to post on facebook along with image
    /// - Parameter img: Pass UIImage
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)

    func FJPostTextAndImageOnFacebook(_ txtMessage: String, img: UIImage?, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestPostData = {() -> Void in
            if AccessToken.current?.hasGranted(permission: "publish_actions") ?? false {
                if txtMessage.count>0 && !img!.isKind(of: UIImage.self) {
                    GraphRequest(graphPath: "me/feed", parameters: ["message": txtMessage], httpMethod: .post).start(completion: { (_, result, error) in

                        if error != nil {
                            print("text not sent")
                        } else {
                            print("post id \(String(describing: result))")
                        }
                    })

                } else if txtMessage.count>0 && img!.isKind(of: UIImage.self) {
                    let imageData: Data = img!.pngData()!
                    let param: [AnyHashable: Any] = [
                        "message": txtMessage,
                        "image.png": imageData
                    ]

                    GraphRequest(graphPath: "me/photos", parameters: (param as? [String: Any]) ?? [:], httpMethod: .post).start(completion: { (_, result, error) in

                        if error != nil {
                            print("text not sent")
                            completionHandler(nil, false)
                        } else {
                            print("post id \(String(describing: result))")
                            completionHandler(result as AnyObject, true)
                        }
                    })
                }
            }
        }

        if AccessToken.current != nil {
            sendRequestPostData()
        } else {

            loginWithPublishPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestPostData()
                }
            })
        }
    }

    // MARK: FJFacebook POST VIDEO
    /// Post Image and text on facebook
    /// - Parameter txtMessage: Message you want to post on facebook along with image
    /// - Parameter txtDescription: Description of Video
    /// - Parameter videoURL: Pass url of video
    /// - Parameter img: Pass thumbnail of video as UIImage
    /// - Returns: FJFacebookCompletionHandler = (obj:AnyObject?, success:Bool?)

    func FJPostVideoOnFacebook(_ videoURL: String?, txtMessage: String?, txtDescription: String?, img: UIImage?, completionHandler:@escaping FJFacebookCompletionHandler) {
        let sendRequestPostData = {() -> Void in
            if AccessToken.current?.hasGranted(permission: "publish_actions") ?? false {
                // let imageData: NSData = UIImagePNGRepresentation(img)?
                let param: [AnyHashable: Any] = [
                    "title": txtMessage!,
                    "description": txtDescription!,
                    "file_url": videoURL!
                ]

                GraphRequest(graphPath: "me/videos", parameters: (param as? [String: Any]) ?? [:], httpMethod: .post).start(completion: { (_, result, error) in

                    if error != nil {
                        print("text not sent")
                        completionHandler(nil, false)
                    } else {
                        print("post id \(String(describing: result))")
                        completionHandler(result as AnyObject, true)
                    }
                })

            }
        }

        if AccessToken.current != nil {
            sendRequestPostData()
        } else {
            loginWithPublishPermission(completionHandler: { (result, error) in
                if error != nil {
                    completionHandler(nil, false)
                } else if (result?.isCancelled)! {
                    completionHandler(nil, false)
                } else {
                    sendRequestPostData()
                }
            })
        }
    }

    // MARK: Facebook Login With Read Permission

    func loginWithReadPermission (completionHandler : @escaping LoginManagerLoginResultBlock) {
        let loginManager: LoginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: APPDELEGATE.window?.rootViewController, handler: { (result, error) in
            completionHandler(result, error)
        })
    }

    // MARK: Facebook Login With Publish Permission

    func loginWithPublishPermission (completionHandler : @escaping LoginManagerLoginResultBlock) {
        let loginManager: LoginManager = LoginManager()
        loginManager.logIn(permissions: ["publish_actions"], from: APPDELEGATE.window?.rootViewController) { (result, error) in
            completionHandler(result, error)
        }
    }

    // MARK: Facebook Graph API for Fetch User's Different Data

    func graphAPIWithGraphPath(graphPath: String, params: [String: String]?, completionHandler : @escaping GraphRequestCompletion) {
        let token = AccessToken.current?.tokenString
        GraphRequest(graphPath: graphPath, parameters: params ?? [:], tokenString: token ?? "", version: nil, httpMethod: .post).start { connection, result, error in
            completionHandler(connection, result, error)
        }

    }
}
