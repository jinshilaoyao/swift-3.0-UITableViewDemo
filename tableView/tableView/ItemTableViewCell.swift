//
//  ItemTableViewCell.swift
//  tableView
//
//  Created by yesway on 2017/5/11.
//  Copyright © 2017年 yesway. All rights reserved.
//

import UIKit
import Foundation

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
        
        iconImage = UIImageView()
        iconImage?.image = UIImage(named: "2")
        iconImage?.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(iconImage!)
        iconImage?.isOpaque = true
        
        contentLabel = UILabel()
        contentLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentLabel?.numberOfLines = 0
        
        contentLabel?.translatesAutoresizingMaskIntoConstraints = false
        contentLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(contentLabel!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updata(item: VVItem) {
        self.item = item
        viewModel = VVItemViewModel(item: item)
        contentLabel?.text = item.text
        guard let vm = viewModel else {
            return
        }
        
        //let height = item.text.stringHeightWith(fontSize: <#T##CGFloat#>, width: <#T##CGFloat#>, lineSpace: <#T##CGFloat#>)
        let height = vm.calItemContentHeight(contentSize: CGSize(width: Int(UIScreen.screenWidth() - 50 - 3*8), height: 1000))
        contentHeight = height
        
        changeContentLabelHeight()
    }
    
    func calculateRowHeight(contentText text: String, textFont font: Int) ->CGFloat {
        
        let text = text as NSString
        let dict = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let rect = text.boundingRect(with: CGSize(width: CGFloat(UIScreen.screenWidth() - 50 - 3*8), height: 0), options: .usesLineFragmentOrigin, attributes: dict as? [String : AnyObject], context: nil)
        
        return rect.height
    }
    /*
    - (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.width - 30, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
    }
     */
    
    func getCellHeight() ->CGFloat {
        
        let height = contentHeight > 50 ? contentHeight : 50
        
        return height + 2 * 8
    }
    

    func changeContentLabelHeight() {
        var temp = contentLabel?.frame
        temp!.size.height = contentHeight
        contentLabel?.frame = temp!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let iconImage = self.iconImage, let label = contentLabel else {
            return
        }
        
        let margin: CGFloat = 8
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
            iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin),
            iconImage.widthAnchor.constraint(equalToConstant: (iconImage.image?.size.width)!),
            iconImage.heightAnchor.constraint(equalToConstant: (iconImage.image?.size.height)!)
            ])
        
        
        let labelWidth: CGFloat = CGFloat(UIScreen.screenWidth()) - (iconImage.image?.size.height)! - 3*8
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            label.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 8),
            label.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8),
            label.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension String{
    
    //MARK:获得string内容高度
    
    func stringHeightWith(fontSize:CGFloat,width:CGFloat,lineSpace : CGFloat)->CGFloat{
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        //        let size = CGSizeMake(width,CGFloat.max)
        
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpace
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }//funcstringHeightWith
    
}//extension end
