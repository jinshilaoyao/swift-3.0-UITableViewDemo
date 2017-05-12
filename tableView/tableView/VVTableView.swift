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
        var cell = self.dequeueReusableCell(withIdentifier: "cell") as? ItemTableViewCell
        if cell == nil {
            cell = ItemTableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let item = datas[indexPath.row]
        cell?.updata(item: item)
        let height = cell?.getCellHeight() ?? 50

        let range = Range(indexPath.row..<(indexPath.row+1))
        cacheCellHeightArray.replaceSubrange(range, with: [height])
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = cacheCellHeightArray[indexPath.row]
        
        if height > 0 {
            return height
        } else {
            return 50
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let ip = indexPathForRow(at: CGPoint(x: 0, y: targetContentOffset.pointee.y)), let cip = indexPathsForVisibleRows?.first else {
            return
        }
        let skipCount = 8
        
        if (labs(cip.row - ip.row) > skipCount) {
            
            let temp = indexPathsForRows(in: CGRect(x: 0, y: targetContentOffset.pointee.y, width: frame.size.width, height: frame.size.width))
            let arr = Array(arrayLiteral: temp)
            
            if (velocity.y<0) {
            
            } else {
                
            }
        }
    }
}
