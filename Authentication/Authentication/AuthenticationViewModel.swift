//
//  AuthenticationViewModel.swift
//  Authentication
//
//  Created by Abhishek Goel on 02/01/23.

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase

class AuthenticationViewModel {
    var userGoogleData = Observable<User?>(value: nil)
    var facebookUserData = Observable<[String: AnyObject]?>(value: [:])
    
    func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        return alert
    }
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Error in account creation")
                return
            }
        }
    }
    
    func googleSignIn(viewController: UIViewController) {
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { user, error in
            if error != nil {
                return
            }
            
            guard
                let idToken = user?.authentication.idToken,
                let accessToken = user?.authentication.accessToken
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            Auth.auth().signIn(with: credential, completion: {
                userAuth, error in
                if error != nil {
                    print("Error in signing")
                    return
                }
                self.userGoogleData.value = userAuth?.user
            })
        }
    }
    
    func facebookSignIn(isTapped: Bool = false, viewController: UIViewController) {
        let loginManager = LoginManager()
        if let token = AccessToken.current, !token.isExpired, !isTapped {
            let tokenString = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: tokenString, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result)")
            }
            return
        }
        
        loginManager.logIn(permissions: ["public_profile","email"], from: viewController) { loginResult, error in
            if error != nil {
                print("Errorsome")
                return
            }
            let tokenString = loginResult?.token?.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: tokenString, version: nil, httpMethod: .get)
            
            request.start(completion: { (connection, result, error) -> Void in
                if ((error) != nil) {
                    print("Error: \(String(describing: error))")
                    return
                }
                self.facebookUserData.value = result as? [String: AnyObject]
            })
        }
    }
}
