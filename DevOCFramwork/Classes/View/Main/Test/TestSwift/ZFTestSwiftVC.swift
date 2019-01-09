//
//  ZFTestSwiftVC.swift
//  DevOCFramwork
//
//  Created by 张志方 on 2019/1/8.
//  Copyright © 2019年 志方. All rights reserved.
//

import UIKit

class ZFTestSwiftVC: UIViewController {
    
    @objc var tit: String? = String()
    @objc var user: ZFUser = ZFUser()
    @objc var statusVM: ZFStatusedList_ViewModel = ZFStatusedList_ViewModel()
    var tableview:UITableView = UITableView()
    
    @objc func test(tit:String){
        self.tit = tit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.tit
        self.view.backgroundColor = UIColor.white
        print(self.user.userId)
        self.createView()
        self.loadData()
    }
    
    
    
    func loadData() {
        self.statusVM.loadStatus(true) { (isSuccess, shouldRefresh) in
            self.tableview.reloadData()
        }
    }
}

extension ZFTestSwiftVC: UITableViewDelegate, UITableViewDataSource{
    func createView() {
        tableview = UITableView.init()
        self.view.addSubview(tableview)
        tableview.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self.view)
        }
        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.register(UINib.init(nibName: "ZFStatusNormalCell", bundle: nil), forCellReuseIdentifier: "originalCellId")
        self.tableview.register(UINib.init(nibName: "ZFStatusRetweetedCell", bundle: nil), forCellReuseIdentifier: "retweetedCellId")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusVM.statusList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm: ZFStatusViewModel = self.statusVM.statusList?[indexPath.row] as! ZFStatusViewModel;
        let cellId = vm.status.retweeted_status == nil ? "originalCellId" : "retweetedCellId"
        let cell: ZFStatusCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ZFStatusCell
        cell.viewModel = vm
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model: ZFStatusViewModel = self.statusVM.statusList![indexPath.row] as! ZFStatusViewModel
        return model.rowHeight
    }
}
