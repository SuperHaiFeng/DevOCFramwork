//
//  ZFInheritCell.swift
//  DevOCFramwork
//
//  Created by 张志方 on 2019/1/10.
//  Copyright © 2019年 志方. All rights reserved.
//

import UIKit

class ZFInheritCell: UITableViewCell {
    let content: UIView = UIView()
    let title: UILabel = UILabel()
    let leftTag: UIView = UIView()
    let expiredImg: UIImageView = UIImageView()
    let expiredLabel: UILabel = UILabel()
    let desc: UILabel = UILabel()
    let desc2: UILabel = UILabel()
    let time: UILabel = UILabel()
    let rightView: UIView = UIView()
    let joinView: UIView = UIView()
    
    let joinImg: UIImageView = UIImageView()
    let joinLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(red: 246/255.0, green: 247/255.0, blue: 249/255.0, alpha: 0)
        self.createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ZFInheritCell {
    func createView() {
        self.title.text = "k加息券"
        self.desc.text = "项目加息2.34%"
        self.desc2.text = "2.30%加息-3月期及以下智选服务可用"
        self.time.text = "有效期至 2019-11-11 23:59:59"
        self.expiredLabel.text = "即将过期"
        self.joinLabel.text = "点\n击\n使\n用"
        self.expiredImg.image = UIImage.init(named: "Shape")
        self.joinImg.image = UIImage.init(named: "join")
        self.title.font = UIFont.systemFont(ofSize: 14)
        self.desc.font = UIFont.systemFont(ofSize: 16)
        self.desc2.font = UIFont.systemFont(ofSize: 12)
        self.time.font = UIFont.systemFont(ofSize: 12)
        self.expiredLabel.font = UIFont.systemFont(ofSize: 13)
        self.joinLabel.font = UIFont.systemFont(ofSize: 14)
        self.joinLabel.numberOfLines = 0
        self.desc2.numberOfLines = 0
        self.content.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.content)
        self.content.addSubview(self.title)
        self.content.addSubview(self.leftTag)
        self.content.addSubview(self.expiredImg)
        self.content.addSubview(self.expiredLabel)
        self.content.addSubview(self.desc)
        self.content.addSubview(self.desc2)
        self.content.addSubview(self.time)
        self.content.addSubview(self.rightView)
        self.rightView.addSubview(self.joinView)
        self.joinView.addSubview(self.joinImg)
        self.joinView.addSubview(self.joinLabel)
        
        self.content.layer.cornerRadius = 5
        self.content.layer.borderWidth = 0.5
        self.content.layer.borderColor = UIColor.gray.cgColor
        self.leftTag.backgroundColor = UIColor.red
        self.title.textColor = UIColor.init(red: 93/255.0, green: 100/255.0, blue: 110/255.0, alpha: 1)
        self.desc.textColor = UIColor.init(red: 247/255.0, green: 95/255.0, blue: 82/255.0, alpha: 1)
        self.desc2.textColor = UIColor.gray
        self.time.textColor = UIColor.gray
        self.joinLabel.textColor = UIColor.init(red: 247/255.0, green: 95/255.0, blue: 82/255.0, alpha: 1)
        self.expiredLabel.textColor = UIColor.gray
        self.rightView.backgroundColor = UIColor.init(red: 255/255.0, green: 249/255.0, blue: 248/255.0, alpha: 1)
        self.content.clipsToBounds = true
        
        self.content.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.contentView)?.setOffset(22)
            make?.right.mas_equalTo()(self.contentView)?.setOffset(-22)
            make?.top.mas_equalTo()(self.contentView)
            make?.bottom.mas_equalTo()(self.contentView)?.setOffset(-10)
        }
        self.leftTag.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.content)
            make?.top.mas_equalTo()(self.content)?.setOffset(21)
            make?.height.mas_equalTo()(16)
            make?.width.mas_equalTo()(2)
        }
        self.title.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.content)?.setOffset(20)
            make?.top.mas_equalTo()(self.content)?.setOffset(19)
            make?.right.mas_equalTo()(self.expiredImg.mas_left)?.setOffset(10)
        }
        self.expiredImg.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(self.expiredLabel.mas_left)?.setOffset(-7)
            make?.height.width()?.mas_equalTo()(12)
            make?.centerY.mas_equalTo()(self.expiredLabel)
        }
        self.expiredLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.content)?.setOffset(19)
            make?.right.mas_equalTo()(self.rightView.mas_left)?.setOffset(-10)
        }
        self.rightView.mas_makeConstraints { (make) in
            make?.top.bottom()?.right()?.mas_equalTo()(self.content)
            make?.width.mas_equalTo()(48)
        }
        self.joinView.mas_makeConstraints { (make) in
            make?.centerX.centerY()?.mas_equalTo()(self.rightView)
        }
        self.joinImg.mas_makeConstraints { (make) in
            make?.top.left()?.right()?.mas_equalTo()(self.joinView)
            make?.width.height()?.mas_equalTo()(18)
        }
        self.joinLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.joinImg.mas_bottom)?.setOffset(10)
            make?.bottom.mas_equalTo()(self.joinView)
        }
        self.desc.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.title.mas_bottom)?.setOffset(12)
            make?.left.mas_equalTo()(self.title.mas_left)
        }
        self.desc2.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.title.mas_left)
            make?.top.mas_equalTo()(self.desc.mas_bottom)?.setOffset(12)
            make?.right.mas_equalTo()(self.rightView.mas_left)?.setOffset(-10)
        }
        self.time.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.title.mas_left)
            make?.top.mas_equalTo()(self.desc2.mas_bottom)?.setOffset(8)
            make?.bottom.mas_equalTo()(self.content.mas_bottom)?.setOffset(-19)
        }
    }
}

extension ZFInheritCell {
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.leftTag.backgroundColor = UIColor.red
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.leftTag.backgroundColor = UIColor.red
    }
}
