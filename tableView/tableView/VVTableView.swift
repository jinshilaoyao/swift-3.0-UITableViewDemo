//
//  VVTableView.swift
//  tableView
//
//  Created by yesway on 2017/5/10.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class VVTableView: UITableView {

    fileprivate var cacheCellHeightArray = [CGFloat]()
    var datas = [VVItem]()
    var needLoadArr = [Any]()
    var scrollToToping: Bool = false
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        dataSource = self
        delegate = self
        datas = [VVItem]()
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
           datas.append(item)
        }
        
        cacheCellHeightArray = Array(repeating: -1, count: datas.count)
    }
    
}
extension VVTableView: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let item = datas[indexPath.row]
        cell?.textLabel?.text = item.text
        cell?.textLabel?.numberOfLines = 0;
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = cacheCellHeightArray[indexPath.row]
        
        if height > 0 {
            return height
        } else {
            
            let item = datas[indexPath.row]
            let vm = VVItemViewModel(item: item)
            let height = vm.calItemContentHeight(contentSize: CGSize(width: UIScreen.main.bounds.size.width - 32, height: 1000))
            cacheCellHeightArray.replaceSubrange(Range(indexPath.row..<(indexPath.row + 1)), with: [height])
            
            return height
        }
    }
    
}
