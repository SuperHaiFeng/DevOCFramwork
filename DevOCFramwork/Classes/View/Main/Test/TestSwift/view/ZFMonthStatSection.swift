//
//  ZFMonthStatSection.swift
//  DevOCFramwork
//
//  Created by 张志方 on 2019/3/27.
//  Copyright © 2019年 志方. All rights reserved.
//

import UIKit

class ZFMonthStatSection: UITableViewHeaderFooterView {

    @objc var tapClosure:((_ sect: ZFMonthStatSection) -> Void)?

    var content = UIView()
    var titleLabel = UILabel()
    var descLabel = UILabel()
    var arrow = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    func createView() {
        content.backgroundColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.darkGray
        descLabel.font = UIFont.systemFont(ofSize: 18)
        descLabel.textColor = UIColor.red
        arrow.image = UIImage.init(named: "downArrow")
        arrow.contentMode = UIView.ContentMode.scaleAspectFit
        
        self.addSubview(content)
        content.addSubview(titleLabel)
        content.addSubview(descLabel)
        content.addSubview(arrow)
        
        content.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self)
        }
        
        titleLabel.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(content.mas_left)?.setOffset(20)
            make?.centerY.mas_equalTo()(content.mas_centerY)
        }
        
        descLabel.mas_makeConstraints { (make) in
            make?.centerY.mas_equalTo()(content.mas_centerY)
            make?.right.mas_equalTo()(arrow.mas_left)?.setOffset(-8)
        }
        
        arrow.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(content.mas_right)?.setOffset(-20)
            make?.centerY.mas_equalTo()(content.mas_centerY)
            make?.height.width()?.mas_equalTo()(14)
        }
        
        titleLabel.text = "2019年"
        descLabel.text = "¥ 1000000"
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        content.addGestureRecognizer(tap)
        
    }
    
    @objc func tapClick() {
        if tapClosure != nil {
            tapClosure!(self)
        }
    }
    
    @objc func setWithModel(model:YearItems){
        titleLabel.text = model.profit_year_name! as String
        descLabel.text = model.profit_year_value! as String
        arrow.image = UIImage.init(named: model.isOpen! ? "upArrow" : "downArrow")
    }
    
    @objc func setUp(){
        UIView.animate(withDuration: 0.3) {
            self.arrow.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double(Double.pi-0.00001)))
        }
    }
    
    @objc func setDown() {
        UIView.animate(withDuration: 0.3) {
            self.arrow.transform = CGAffineTransform.init(rotationAngle: CGFloat(-Double.pi+0.000001))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
