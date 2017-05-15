//
//  VVItemViewModel.swift
//  tableView
//
//  Created by yesway on 2017/5/11.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class VVItemViewModel: NSObject {
    
    private var item: VVItem
    
    init(item: VVItem) {
        self.item = item
        super.init()
    }
    
    func calItemContentHeight(contentSize size: CGSize) -> CGFloat {
        let frame = item.text as NSString
        let font = UIFont.systemFont(ofSize: 15)
        let value = frame.sizeWithConstrained(to: size, from: font, lineSpace: 4)
        return value.height
    }
    
    func getItemContentHeight() -> CGFloat {
        
        var frame = item.frame
        frame = frame.replacingOccurrences(of: "{", with: "")
        frame = frame.replacingOccurrences(of: "}", with: "")

        let str2Array=frame.components(separatedBy: ",")
        let height = (str2Array.last! as NSString).doubleValue
        
        return CGFloat(height)
    }
    
}
