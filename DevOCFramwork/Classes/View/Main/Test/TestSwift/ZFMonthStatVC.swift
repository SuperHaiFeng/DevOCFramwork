//
//  ZFMonthStatVC.swift
//  DevOCFramwork
//
//  Created by 张志方 on 2019/3/27.
//  Copyright © 2019年 志方. All rights reserved.
//

import UIKit

class ZFMonthStatVC: ZFBaseViewController {
    var model: MonthStatModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 288
        self.view.backgroundColor = UIColor.init(red: 244/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
        self.title = "月度统计"
    }
    
    override func loadData() {
        model = MonthStatModel()
        let items = NSMutableArray()
        let lists = NSMutableArray()
        let years = NSMutableArray()
        var yearNum = 2019
        for j in 0...4{
            let year = YearItems()
            year.empty_message = "这一年没有利息进账"
            yearNum-=1
            year.profit_year_name = "\(yearNum)年累计利息" as NSString
            year.profit_year_value = "¥ \(arc4random() % 1000000)" as NSString
            lists.removeAllObjects()
//            if j == 0{
                year.isOpen = true
//            }
            for i in 1...12 {
                let list = MonthList()
                list.profit_month_name = "\(i)月" as NSString
                list.profit_month_value = "¥ \(arc4random() % 10000000)" as NSString
                list.profit_month_tip = "（截止到今日零点）"
                items.removeAllObjects()
                let num = arc4random() % 5 + 1
                for _ in 0...num{
                    let item = Items()
                    item.profit_type = "智选服务"
                    item.profit_value = "¥ \(arc4random() % 10000000)" as NSString
                    items.add(item)
                }
                list.items = items.copy() as? [Items]
                if j < 5 {
                    lists.add(list)
                }
            }
            year.month_lists = lists.copy() as? [MonthList]
            years.add(year)
        }
        model?.year_items = years.copy() as? [YearItems]
        self.tableView.reloadData()
        
        
    }
}

//MARK: tableview delegate
extension ZFMonthStatVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.year_items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let year: YearItems = model?.year_items?[section] ?? YearItems()
        return year.isOpen! ? year.month_lists!.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MONTH_CELL_IDENTIFIER")
        if cell == nil {
            cell = ZFMonthStatCell.init(style: .default, reuseIdentifier: "MONTH_CELL_IDENTIFIER")
        }
        let year = model?.year_items?[indexPath.section]
        (cell as! ZFMonthStatCell).setModel(model: year!.month_lists![indexPath.row], lastOne: year!.month_lists![indexPath.row] == year!.month_lists?.last)
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MONTH_HEADER_IDENTIFIER")
        if header == nil {
            header = ZFMonthStatSection.init(reuseIdentifier: "MONTH_HEADER_IDENTIFIER")
        }
        let year = model!.year_items![section]
        (header as! ZFMonthStatSection).setWithModel(model: year)
        (header as! ZFMonthStatSection).tapClosure={[weak self] (sect:ZFMonthStatSection) in
            year.isOpen! = !year.isOpen!
            year.isOpen! ? sect.setUp() : sect.setDown()
            let indecSet = NSIndexSet.init(index: section)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2, execute: {
                UIView.performWithoutAnimation {
                    self?.tableView.reloadSections(indecSet as IndexSet, with: UITableView.RowAnimation.none)
                    if !year.isOpen! {
                        self?.scrollUpSection(section: section)
                    }
                }
            })
        }
        
        return header
    }
    
    func scrollUpSection(section: NSInteger) {
        if section > 0 {
            let year = model!.year_items![section-1]
            if year.isOpen! {
                self.tableView.scrollToRow(at: NSIndexPath.init(row: 0, section: section-1) as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 74
    }
    
}

class Items: NSObject {
    @objc var profit_type: NSString?
    @objc var profit_value: NSString?
    @objc var icon_url: NSString?
}

class MonthList: NSObject {
    @objc var profit_month_name: NSString?
    @objc var profit_month_value: NSString?
    @objc var profit_month_tip: NSString?
    @objc var items: [Items]?
}

class YearItems: NSObject {
    override init() {
        super.init()
    }
    @objc var empty_message:NSString?
    @objc var profit_year_name: NSString?
    @objc var profit_year_value: NSString?
    @objc var month_lists: [MonthList]?
    var isOpen: Bool?
}

class MonthStatModel: NSObject {
    override init() {
        super.init()
    }
    @objc var year_items:[YearItems]?
    
}
