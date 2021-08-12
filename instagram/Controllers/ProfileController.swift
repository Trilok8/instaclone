//
//  ProfileController.swift
//  instagram
//
//  Created by boyapalli trilok reddy on 10/08/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ProfileController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let imageArray = [UIImage(named: "1.jpeg"),UIImage(named: "2.jpeg"),UIImage(named: "3.jpeg"),UIImage(named: "4.jpeg"),UIImage(named: "5.jpeg"),UIImage(named: "6.jpeg"),UIImage(named: "7.jpeg"),UIImage(named: "8.jpeg"),UIImage(named: "9.jpeg"),UIImage(named: "10.jpeg")]
    let videoArray = [1,2,3,4,5]

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgviewUserImage: UIImageView!
    @IBOutlet weak var btnSignOut: GIDSignInButton!
    @IBOutlet weak var collectionGallery: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SETUPUI()
        setupCollectionView()
    }
    
    func SETUPUI() {
        imgviewUserImage.image = UIImage(named: "user.jpeg")
        imgviewUserImage.layer.cornerRadius = imgviewUserImage.frame.width/2
        
        let currentUser = Auth.auth().currentUser
        if let username = currentUser?.displayName {
            lblUsername.text = username
            print(username)
        }
        if let email = currentUser?.email {
            print(email)
        }
    }
    
    func setupCollectionView() {
        collectionGallery.register(UINib(nibName: "profileGalleryCell", bundle: nil), forCellWithReuseIdentifier: "profileGalleryCell")
        collectionGallery.delegate = self
        collectionGallery.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionGallery.collectionViewLayout = flowLayout
        collectionGallery.showsVerticalScrollIndicator = false
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 2
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileGalleryCell", for: indexPath) as! profileGalleryCell
        let number =  arc4random_uniform(9)
        cell.imgView.image = imageArray[Int(number)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionGallery.frame.width/3 - 2, height: collectionGallery.frame.width/3)
    }
    
    @IBAction func actionSignOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: storyboardID_LoginController)
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            if let controller = vc {
                sceneDelegate?.changeRootViewController(controller)
            }
        }
        catch let err as NSError {
            print(err)
        }
    }
    
}
