//
//  ZFMonthStatCell.swift
//  DevOCFramwork
//
//  Created by 张志方 on 2019/3/27.
//  Copyright © 2019年 志方. All rights reserved.
//

import UIKit

class ZFMonthStatCell: UITableViewCell {
    
    var content = UIView()
    var flag = UIView()
    var monthLabel = UILabel()
    var ammountLabel = UILabel()
    var line = UIView()
    var profitView = UIView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(red: 244/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
        createView()
    }
    
    func createView() {
        content.backgroundColor = UIColor.white
        content.layer.cornerRadius = 6
        flag.backgroundColor = UIColor.red
        flag.layer.cornerRadius = 1
        monthLabel.font = UIFont.systemFont(ofSize: 16)
        monthLabel.textColor = UIColor.darkGray
        ammountLabel.font = UIFont.systemFont(ofSize: 17)
        ammountLabel.textColor = UIColor.red
        line.backgroundColor = UIColor.gray
        
        self.contentView.addSubview(content)
        content.addSubview(flag)
        content.addSubview(monthLabel)
        content.addSubview(ammountLabel)
        content.addSubview(line)
        content.addSubview(profitView)
        
        content.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.contentView.mas_left)?.setOffset(20)
            make?.right.mas_equalTo()(self.contentView.mas_right)?.setOffset(-20)
            make?.top.mas_equalTo()(self.contentView.mas_top)?.setOffset(12)
            make?.bottom.mas_equalTo()(self.contentView.mas_bottom)
        }
        
        flag.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(content.mas_left)
            make?.top.mas_equalTo()(content.mas_top)?.setOffset(32)
            make?.height.mas_equalTo()(12)
            make?.width.mas_equalTo()(2)
        }
        
        monthLabel.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(flag.mas_right)?.setOffset(20)
            make?.centerY.mas_equalTo()(flag.mas_centerY)
        }
        
        ammountLabel.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(content.mas_right)?.setOffset(-22)
            make?.centerY.mas_equalTo()(flag.mas_centerY)
        }
        
        line.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(monthLabel.mas_bottom)?.setOffset(16)
            make?.left.mas_equalTo()(content.mas_left)?.setOffset(22)
            make?.right.mas_equalTo()(content.mas_right)?.setOffset(-22)
            make?.height.mas_equalTo()(0.5)
        }
        
        profitView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(line.mas_bottom)?.setOffset(18)
            make?.left.bottom()?.right()?.mas_equalTo()(content)
        }
        
    }
    
    @objc func setModel(model: MonthList, lastOne: Bool){
        for view in profitView.subviews {
            view.removeFromSuperview()
        }
        monthLabel.text = model.profit_month_name! as String
        ammountLabel.text = model.profit_month_value! as String
        var place: SectionCell? = nil
        for item in model.items! {
            let itemView = SectionCell.init(title: item.profit_type!, desc: item.profit_value!)
            profitView.addSubview(itemView)
            if (place != nil) {
                itemView.mas_makeConstraints {(make) in
                    make?.left.mas_equalTo()(profitView.mas_left)?.setOffset(22)
                    make?.top.mas_equalTo()(place?.mas_bottom)?.setOffset(18)
                    make?.right.mas_equalTo()(profitView.mas_right)?.setOffset(-22)
                };
            }else {
                itemView.mas_makeConstraints {(make) in
                    make?.left.mas_equalTo()(self.profitView.mas_left)?.setOffset(22)
                    make?.top.mas_equalTo()(self.profitView.mas_top)
                    make?.right.mas_equalTo()(self.profitView.mas_right)?.setOffset(-22)
                };
            }
            if (model.items?.last == item) {
                itemView.mas_updateConstraints {(make) in
                    make?.bottom.mas_equalTo()(self.profitView.mas_bottom)?.setOffset(-28);
                };
            }
            place = itemView;
        }
        self.content.mas_updateConstraints {(make) in
            make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.setOffset(lastOne ? -12 : 0);
        };
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class SectionCell: UIView {
    
    @objc var titleLabel = UILabel()
    @objc var descLabel = UILabel()
    
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0 ))
    }
    
    convenience init(title:NSString , desc:NSString) {
        self.init()
        createView()
        titleLabel.text = title as String
        descLabel.text = desc as String
    }
    
    func createView() {
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.init(red: 120/255.0, green: 132/255.0, blue: 160/255.0, alpha: 1)
        descLabel.font = UIFont.systemFont(ofSize: 13)
        descLabel.textColor = UIColor.darkGray
        
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        
        titleLabel.mas_makeConstraints { (make) in
            make?.left.top()?.bottom().mas_equalTo()(self)
        }
        
        descLabel.mas_makeConstraints { (make) in
            make?.right.top()?.bottom().mas_equalTo()(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
