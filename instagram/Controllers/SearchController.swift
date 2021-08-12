//
//  SearchController.swift
//  instagram
//
//  Created by boyapalli trilok reddy on 11/08/21.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var txtFieldSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        SETUPUI()
    }
    
    func SETUPUI() {
        txtFieldSearch.leftViewMode = UITextField.ViewMode.always
        txtFieldSearch.layer.cornerRadius = 3
        txtFieldSearch.textRect(forBounds: CGRect(x: 50, y: 0, width: txtFieldSearch.frame.width - 50, height: txtFieldSearch.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = .black
        txtFieldSearch.leftView = imageView
    }

}
