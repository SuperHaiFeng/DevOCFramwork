//
//  ZFInheritOC.swift
//  DevOCFramwork
//
//  Created by 张志方 on 2019/1/10.
//  Copyright © 2019年 志方. All rights reserved.
//

import UIKit

class ZFInheritOC: ZFBaseViewController {
    
    @objc var tit: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.tableView.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = self.tit
    }
    
    //重写OC父类中的方法
    override func loadData() {
        self.refreshController.endRefreshing()
        self.tableView.reloadData()
    }
    
}

extension ZFInheritOC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "456")
        if cell == nil {
            cell = ZFInheritCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "456")
        }
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UIView = UIView()
        let headertitle: UILabel = UILabel()
        header.addSubview(headertitle)
        header.backgroundColor = self.tableView.backgroundColor
        headertitle.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(header)?.setOffset(22)
            make?.centerY.mas_equalTo()(header)
        }
        headertitle.text = "每单仅可使用一张"
        headertitle.font = UIFont.systemFont(ofSize: 14)
        headertitle.textColor = UIColor.init(red: 120/255.0, green: 132/255.0, blue: 160/255.0, alpha: 1)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
