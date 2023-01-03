//
//  ViewController.swift
//  Authentication
//
//  Created by Abhishek Goel on 27/12/22.

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {
    private let viewModel = AuthenticationViewModel()
    private var name = " "
    private var emailId = " "
    private var url = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.facebookSignIn(viewController: self)
    }
    
    func bind() {
        viewModel.userGoogleData.subcribe { [weak self] user in
            guard let self = self, let user = user else { return }
            self.name = user.displayName ?? ""
            self.emailId = user.email ?? ""
            print(self.name)
            print(self.emailId)
        }
        
        viewModel.facebookUserData.subcribe { [weak self] user in
            guard let self = self, let user = user else { return }
            self.name = user["first_name"] as! String
            self.emailId = user["email"] as! String
            print(self.name)
            print(self.emailId)
        }
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnGoogle: UIButton! {
        didSet {
            btnGoogle.setTitle("Sign in with Google", for: .normal)
            btnGoogle.setImage(UIImage(named: "google"), for: .normal)
        }
    }
    @IBOutlet weak var btnFacebook: UIButton! {
        didSet {
            btnFacebook.setTitle("Sign in with Facebook", for: .normal)
            btnFacebook.setImage(UIImage(named: "facebook"), for: .normal)
        }
    }
    
    @IBAction func btnSignInTapped(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            print("Enter valid credentails")
            self.present(viewModel.showAlert(title: "Error", message: "Enter valid credentials"), animated: true)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { userAuth, error in
            if error != nil {
                print("No account found")
                self.present(self.viewModel.showAlert(title: "Create Account", message: "Account is being created for the email provided"), animated: true)
                self.viewModel.createAccount(email: email, password: password)
                return
            }
            self.present(self.viewModel.showAlert(title: "Success", message: "You have been signed in"), animated: true)
        }
    }
    @IBAction func btnGoogleTapped(_ sender: Any) {
        viewModel.googleSignIn(viewController: self)
    }
    
    @IBAction func btnFacebookTapped(_ sender: Any) {
        viewModel.facebookSignIn(isTapped: true, viewController: self)
    }
}
