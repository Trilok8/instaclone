//
//  LoginController.swift
//  instagram
//
//  Created by boyapalli trilok reddy on 10/08/21.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginController: UIViewController,GIDSignInDelegate {
    
    @IBOutlet weak var btnGoogleSignIn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }

    
    @IBAction func actionGoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
            print(error.localizedDescription)
            } else {
                guard let userID = user.userID else { return }
                print(userID)
                UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                UserDefaults.standard.setValue(userID, forKey: "userid")
                let db = Database.database(url: "https://instagram-8e3cf-default-rtdb.firebaseio.com").reference()
                let userReference = db.child("users").child(String(userID))
                let values = ["name": user.profile.name, "email": user.profile.email]
                userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if let err = error {
                        print(err.localizedDescription)
                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: storyboardID_TabbarController)
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        if let controller = vc {
                            sceneDelegate?.changeRootViewController(controller)
                        }
                    }
                })
            }
        }
    }
    
}
