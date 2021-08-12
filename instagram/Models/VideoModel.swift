//
//  VideoModel.swift
//  instagram
//
//  Created by boyapalli trilok reddy on 10/08/21.
//

import UIKit

class VideoBaseModel: NSObject {
    var id: Int?
    var width: Int?
    var height: Int?
    var duration: Int?
    var full_res: NSNull?
    var tags: [Any]?
    var url: String?
    var image: String?
    var avg_color: NSNull?
    var user: VideoUser?
    var video_files: [VideoFiles]?
    var video_pictures: [VideoPictures]?
    
    init(dictionary: [AnyHashable: Any]) {
        self.id = dictionary["id"] as? Int
        self.width = dictionary["width"] as? Int
        self.height = dictionary["height"] as? Int
        self.duration = dictionary["duration"] as? Int
        self.full_res = dictionary["full_res"] as? NSNull
        self.tags = dictionary["tags"] as? [Any]
        self.url = dictionary["url"] as? String
        self.image = dictionary["image"] as? String
        self.avg_color = dictionary["avg_color"] as? NSNull
        self.user = dictionary["user"] as? VideoUser
        video_files = [VideoFiles]()
        
        if let video_filesArray = dictionary["video_files"] as? [[String:Any]] {
            for i in video_filesArray {
                let video_file = VideoFiles(dictionary: i)
                video_files?.append(video_file)
            }
        }
        
        video_pictures = [VideoPictures]()
        
        if let video_picturesArray = dictionary["video_pictures"] as? [[String: Any]] {
            for i in video_picturesArray {
                let video_picture = VideoPictures(dictionary: i)
                video_pictures?.append(video_picture)
            }
        }
    }
}

class VideoFiles: NSObject {
    var id: Int?
    var quality: String?
    var file_type: String?
    var width: Int?
    var height: Int?
    var link: String?
    
    init(dictionary: [AnyHashable: Any]) {
        self.id = dictionary["id"] as? Int
        self.quality = dictionary["quality"] as? String
        self.file_type = dictionary["file_type"] as? String
        self.width = dictionary["width"] as? Int
        self.height = dictionary["height"] as? Int
        self.link = dictionary["link"] as? String
    }
}

class VideoPictures: NSObject {
    var id: Int?
    var nr: UInt?
    var picture: String?
    
    init(dictionary: [AnyHashable: Any]) {
        self.id = dictionary["id"] as? Int
        self.nr = dictionary["nr"] as? UInt
        self.picture = dictionary["picture"] as? String
    }
}

class VideoUser: NSObject {
    var id: Int?
    var name: String?
    var url: String?
    init(dictionary: [AnyHashable: Any]) {
        self.id = dictionary["id"] as? Int
        self.name = dictionary["name"] as? String
        self.url = dictionary["url"] as? String
    }
}

