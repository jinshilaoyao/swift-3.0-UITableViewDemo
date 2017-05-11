//
//  ItemTableViewCell.swift
//  tableView
//
//  Created by yesway on 2017/5/11.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    var iconImage: UIImageView?
    
    var contentLabel: UILabel?
    
    var item: VVItem?
    
    var viewModel: VVItemViewModel?
    
    var contentHeight: CGFloat = 0
    
    let margin: CGFloat = 8
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImage = UIImageView(frame: CGRect(x: 8, y: 8, width: 50, height: 50))
        iconImage?.image = UIImage(named: "1")
        self.contentView.addSubview(iconImage!)
        
        contentLabel = UILabel(frame: CGRect(x: 8 + 50 + 8, y: 8, width: Int(UIScreen.screenWidth() - 50 - 3 * 8), height: 50))
        contentLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentLabel?.numberOfLines = 0
        contentLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(contentLabel!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updata(item: VVItem) {
        //contentLabel?.text = item.text
        viewModel = VVItemViewModel(item: item)
    }
    
    func getCellHeight() ->CGFloat {
        
        guard let vm = viewModel else {
            return 0
        }
        
        var height = vm.calItemContentHeight(contentSize: CGSize(width: Int(UIScreen.screenWidth() - 50 - 3*8), height: 1000))
        height = height > 50 ? height : 50
        contentHeight = height
        
        return height + 2 * 8
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        
        
        var temp = contentLabel?.frame
        temp!.size.height = contentHeight
        contentLabel?.frame = temp!
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
