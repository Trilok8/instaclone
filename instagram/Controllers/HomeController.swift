//
//  HomeController.swift
//  instagram
//
//  Created by boyapalli trilok reddy on 10/08/21.
//

import UIKit
import Firebase
import GoogleSignIn

class HomeController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnGetGallery: UIButton!
    let userID = UserDefaults.standard.object(forKey: "userid")
    
    @IBOutlet weak var tblFeed: UITableView!
    
    var imageArray = [UIImage(named: "1.jpeg"),UIImage(named: "2.jpeg"),UIImage(named: "3.jpeg"),UIImage(named: "4.jpeg"),UIImage(named: "5.jpeg"),UIImage(named: "6.jpeg"),UIImage(named: "7.jpeg"),UIImage(named: "8.jpeg"),UIImage(named: "9.jpeg"),UIImage(named: "10.jpeg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFeed.delegate = self
        tblFeed.dataSource = self
        tblFeed.register(UINib(nibName: "FeedCells", bundle: nil), forCellReuseIdentifier: "FeedCells")
        tblFeed.showsVerticalScrollIndicator = false
        tblFeed.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCells", for: indexPath) as! FeedCells
        cell.feedImageView.image = UIImage(named: "\(indexPath.row + 1).jpeg")
        return cell
    }

    @IBAction func actionGetGallery(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageData = image.pngData() {
                uploadImage(image: imageData)
            }
        } else {
            print("something went wrong while getting an image")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(image: Data) {
        let imageName = NSUUID().uuidString
        let storageReference = Storage.storage(url: "gs://instagram-8e3cf.appspot.com").reference().child("images").child("\(imageName).png")
        storageReference.putData(image)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}
