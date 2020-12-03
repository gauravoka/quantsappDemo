//
//  FeedModel.swift
//  quantsappdemo
//
//  Created by Gaurav Oka on 03/12/20.
//

import Foundation

struct FeedModel: Codable, Hashable {
    
    var Status = String()
    var profilePic = String()
    var timeStamp = String()
    var id = Int()
    var name = String()
    var image = String()
    var url = String()

    
    static func returnFeedModel(dict:[String:Any]) -> (FeedModel) {
        
        var deviceMdl = FeedModel()
        
        
        if let Status = dict["status"] {
            deviceMdl.Status = Status as! String
        } else {
            deviceMdl.Status = "Not Available"
        }
        
        
        if let profilePic = dict["profilePic"] {
            deviceMdl.profilePic = profilePic as! String
        } else {
            deviceMdl.profilePic = "Not Available"
        }
        
        if let timeStamp = dict["timeStamp"] {
            deviceMdl.timeStamp = timeStamp as! String
        } else {
            deviceMdl.timeStamp = "Not Available"
        }
        
        if let id = dict["id"] {
            deviceMdl.id = id as! Int
        } else {
            deviceMdl.id = 0
        }
        
        
        if let name = dict["name"] {
            deviceMdl.name = name as! String
        } else {
            deviceMdl.name = "Not Available"
        }
        
        
        if let image = dict["image"] {
            deviceMdl.image = image as! String
        } else {
            deviceMdl.image = "Not Available"
        }
        
       
        
        if let url = dict["url"] {
            deviceMdl.url = url as! String
        } else {
            deviceMdl.url = "Not Available"
        }
        
        return deviceMdl
    }
    
    
    
}

