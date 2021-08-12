//
//  ReelsController.swift
//  instagram
//
//  Created by boyapalli trilok reddy on 10/08/21.
//

import UIKit
import AVKit
import AVFoundation

class ReelsController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var videosArray = [VideoBaseModel]()
    @IBOutlet weak var tblReels: UITableView!
    var reelPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblReels.register(UINib(nibName: "FeedCells", bundle: nil), forCellReuseIdentifier: "FeedCells")
        tblReels.isPagingEnabled = true
        tblReels.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getVideos()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblReels.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCells", for: indexPath) as! FeedCells
        cell.feedImageView.isHidden = true
        cell.selectionStyle = .none
        if let videoFiles = videosArray[indexPath.row].video_files {
            if let link = videoFiles[3].link {
                if let url = URL(string: link) {
                    reelPlayer = AVPlayer(url: url)
                    let playerLayer = AVPlayerLayer(player: reelPlayer)
                    playerLayer.frame = cell.bounds
                    cell.layer.addSublayer(playerLayer)
                    reelPlayer.play()
                }
            }
        }
        return cell
    }
    
    func getVideos() {
        guard let url = URL(string: "https://api.pexels.com/videos/popular?per_page=10") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(pexelsAuthKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: urlRequest) {
                (data, response, error) in
            guard let dataResponse = data,error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do {
                guard let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse, options: []) as? NSDictionary else { return }
                guard let jsonVideoArr = jsonResponse["videos"] as? [NSDictionary] else { return }
                for i in jsonVideoArr {
                    let videoBaseModel = VideoBaseModel(dictionary: i as! [AnyHashable: Any])
                    self.videosArray.append(videoBaseModel)
                }
                DispatchQueue.main.async {
                    self.tblReels.delegate = self
                    self.tblReels.dataSource = self
                    self.tblReels.reloadData()
                }
            } catch let err {
                print("error while parsing", err.localizedDescription)
            }
        }
        task.resume()
    }

}
