//
//  VVTableView.swift
//  tableView
//
//  Created by yesway on 2017/5/10.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class VVTableView: UITableView {

    var datas = [Any]()
    var needLoadArr = [Any]()
    var scrollToToping: Bool = false
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        dataSource = self
        delegate = self
        datas = [Any]()
        needLoadArr = [Any]()
        loadData()
        reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadData() {
        //var temp = [Any](contentsOfFile: Bundle.main.path(forResource: "data", ofType: "plist"))
        guard let temp = Bundle.main.path(forResource: "data", ofType: "plist") else {
            return
        }
        guard let array = NSArray(contentsOfFile: temp) as? [[String: AnyObject]] else {
            return
        }
        for dict in array {
            let item = VVItem(dict: dict)
            print(item.user.allow_all_act_msg)
            
        }
    }
    
}
extension VVTableView: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
