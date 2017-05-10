//
//  VVUser.swift
//  tableView
//
//  Created by yesway on 2017/5/10.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class VVUser: NSObject {
    
    var allow_all_act_msg: String = ""
    var allow_all_comment: String = ""
    var avatar_hd: String = ""
    var avatar_large: String = ""
    var bi_followers_count: String = ""
    var block_app: String = ""
    var block_word: String = ""
    var city: String = ""
    
    //var class: String = ""
    var created_at: String = ""
    var credit_score: String = ""
    //var description: String = ""
    var domain: String = ""
    var favourites_count: String = ""
    var follow_me: String = ""
    var following: String = ""
    var followers_count: String = ""
    var gender: String = ""
    var friends_count: String = ""
    var geo_enabled: String = ""
    var id: String = ""
    var idstr: String = ""
    var lang: String = ""
    var location: String = ""
    var mbrank: String = ""
    var mbtype: String = ""
    var name: String = ""
    var online_status: String = ""
    var pagefriends_count: String = ""
        var profile_image_url: String = ""
        var profile_url: String = ""
        var province: String = ""
    var ptype: String = ""
    
        var remark: String = ""
    var screen_name: String = ""
    var star: String = ""
    var statuses_count: String = ""
        var urank: String = ""
    var url: String = ""
        var verified: String = ""
        var verified_reason: String = ""
        var verified_reason_url: String = ""
        var verified_source: String = ""
    var verified_source_url: String = ""
    var verified_trade: String = ""
        var verified_type: String = ""
    var weihao: String = ""

    
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
                super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
