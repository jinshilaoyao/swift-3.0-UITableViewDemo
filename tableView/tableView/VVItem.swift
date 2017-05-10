//
//  VVItem.swift
//  tableView
//
//  Created by yesway on 2017/5/10.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class VVItem: NSObject{
    
    var frame: String = ""
    var textRect: String = ""
    var attitudes_count: Int = 0
    var cellMode: Int = 0
    var comments_count: Int = 0
    var created_at: String = ""
    var darwin_tags = [String]()
    var fontSize: Int = 0
    var idstr: String = ""
    var lineSpace: Int = 0
    var reposts_count: Int = 0
    
    var pic_urls = [String]()
    var retweeted_status: VVItem?
    var rid: String = ""
    var source: String = ""
    var source_allowclick: String = ""
    var source_type: String = ""
    var text: String = ""
    var user = VVUser()
    
    override init() {
        
    }
    
    convenience init(dict: [String: AnyObject]) {
        self.init()
        setValuesForKeys(dict)
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        
        super.setValuesForKeys(keyedValues)
    }
    

    override func setValue(_ value: Any?, forKey key: String) {
        if key == "pic_urls" {
            guard let array = value as? [[String: AnyObject]] else {
                return
            }
            for dict in array {
                if let urlStr = dict["thumbnail_pic"] as? String{
                    pic_urls.append(urlStr)
                }
            }
            return
        }
        
        if key == "retweeted_status" {
            guard let dict = value as? [String: AnyObject] else {
                return
            }
            retweeted_status = VVItem(dict: dict)
            return
        }
        
        if key == "user" {
            guard let dict = value as? [String: AnyObject] else {
                return
            }
            user = VVUser(dict: dict)
            return
        }
        
        super.setValue(value, forKey: key)
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
