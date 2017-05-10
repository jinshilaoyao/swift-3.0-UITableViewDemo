//
//  ViewController.swift
//  tableView
//
//  Created by yesway on 2017/5/10.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: VVTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = VVTableView(frame: view.bounds, style: .plain)
        tableView?.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView?.scrollIndicatorInsets = (tableView?.contentInset)!
        view.addSubview(tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

