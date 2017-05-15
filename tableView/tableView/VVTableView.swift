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
    var needLoadArr = [IndexPath]()
    var scrollToToping: Bool = false
    var isStartScroll: Bool = false
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        dataSource = self
        delegate = self
        datas = [VVItem]()
        needLoadArr = [IndexPath]()
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
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        needLoadArr.removeAll()
        return super.hitTest(point, with: event)
    }
    
    func loadContent() {
        if self.indexPathsForVisibleRows!.count <= 0 {
            return
        }
        
        if self.visibleCells.count > 0 {
            
            for cell in self.visibleCells {
                guard let cell = cell as? ItemTableViewCell else{
                    return
                }
                
                cell.perpareItemData()
                cell.perpareConstraint()
            }
        }
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
        
        drawCell(cell, with: indexPath)
        
        return cell!
        
    }
    
    func drawCell(_ cell: ItemTableViewCell?, with indexPath: IndexPath) {
        
        let contain = needLoadArr.contains { index -> Bool in
            return indexPath.row == index.row
        }
        
        if needLoadArr.count > 0 && !contain {
            cell?.clear()
            return
        }
        
        let item = datas[indexPath.row]
        
        cell?.updata(item: item)
        let height = cell?.getCellHeight() ?? 50
        
        let range = Range(indexPath.row..<(indexPath.row+1))
        cacheCellHeightArray.replaceSubrange(range, with: [height])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = cacheCellHeightArray[indexPath.row]
        
        if height > 0 {
            return height
        } else {
            return 80
        }
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.reloadRows(at: self.indexPathsForVisibleRows!, with: .none)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        needLoadArr.removeAll()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        isStartScroll = false
        guard let ip = indexPathForRow(at: CGPoint(x: 0, y: targetContentOffset.pointee.y)), let cip = indexPathsForVisibleRows?.first else {
            return
        }
        let skipCount = 12
        
        if (labs(cip.row - ip.row) > skipCount) {
            
            let temp = indexPathsForRows(in: CGRect(x: 0, y: targetContentOffset.pointee.y, width: frame.size.width, height: frame.size.width))
            var arr = temp
            
            let count = 3
            
            if (velocity.y<0) {
                let indexPath = (temp?.last)!
                if indexPath.row+count < datas.count {
                    var i = 1
                    for _ in 1..<count {
                        arr?.append(IndexPath(row: indexPath.row + i, section: 0))
                        i += 1
                    }
                }
            } else {
                let indexPath = (temp?.first)!
                if indexPath.row > count {
                    
                    var i = 1
                    for _ in 1..<count {
                        arr?.append(IndexPath(row: indexPath.row - i, section: 0))
                        i += 1
                    }
                }
            }
            for index in arr! {
                print(index.row)
            }
            needLoadArr = arr!
        }
    }
}
