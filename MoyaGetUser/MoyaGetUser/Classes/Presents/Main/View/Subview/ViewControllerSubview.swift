//
//  ViewControllerSubview.swift
//  MoyaGetUser
//
//  Created by ken.phanith on 2018/09/18.
//  Copyright © 2018 Pich. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then

final class ViewControllerSubview {
    let header = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }
    let label = UILabel().then {
        $0.text = "All Posts"

//        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        $0.textColor = UIColor.white
        $0.font = UIFont(name: "Arail", size: 20.0)
    }
    let addBtn = UIButton().then {
        $0.setTitle("+", for: .normal)
    }
    let list = UITableView()
    
    
    func updateContraint()  {
        self.header.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalToSuperview()
        }
        self.label.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.left.equalTo(self.header.snp.left)
            make.bottom.equalTo(self.header.snp.bottom)
        }
        self.addBtn.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.right.equalTo(self.header.snp.right)
            make.bottom.equalTo(self.header.snp.bottom)
        }
        self.list.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(self.header.snp.bottom)
        }
    }
    
}
