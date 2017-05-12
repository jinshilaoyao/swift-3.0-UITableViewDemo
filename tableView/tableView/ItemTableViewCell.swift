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
        iconImage?.isOpaque = true
        
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
        self.item = item
        viewModel = VVItemViewModel(item: item)
        guard let vm = viewModel else {
            return
        }
        
        let height = vm.calItemContentHeight(contentSize: CGSize(width: Int(UIScreen.screenWidth() - 50 - 3*8), height: 1000))
        contentHeight = height
        
        changeContentLabelHeight()

    }
    
    func getCellHeight() ->CGFloat {
        
        let height = contentHeight > 50 ? contentHeight : 50
        
        return height + 2 * 8
    }
    

    func changeContentLabelHeight() {
        var temp = contentLabel?.frame
        temp!.size.height = contentHeight
        contentLabel?.frame = temp!
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        contentLabel?.text = item?.text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
