
//
//  RootViewController.swift
//  CustomAlert
//
//  Created by CalvinCheung on 16/11/16.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let types = ["AlertView","AlertSheet"]
        
        for i in 0..<2 {
            
            let Btn = UIButton(frame: CGRect(x: 30, y: 80+i*70, width: Int(UIScreen.main.bounds.size.width-60), height: 40))
            Btn.backgroundColor = UIColor.gray
            Btn.setTitle(types[i], for: UIControlState.normal)
            Btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            Btn.layer.cornerRadius = 5
            Btn.tag = i
            Btn.addTarget(self, action: #selector(BtnClicked), for: UIControlEvents.touchUpInside)
            self.view.addSubview(Btn)
        }
    }
    
    func BtnClicked(btn:UIButton) {
        
        if btn.tag == 0 {
            
            let alertView = CustomAlertView(title: "消息提醒", message: "苹果与SAP达成全新企业业务合作将带来“革命性”移动工作体验", cancelButtonTitle: "取 消", sureButtonTitle: "确 定")
            alertView.show()
            // 获取点击事件
            alertView.clickIndexClosure { (index) in
                print("点击了第" + "\(index)" + "个按钮")
            }
            
        }else{
            
            // 标题和取消按钮不传值不会添加到选择面板上
            let sheetView = CustomActionSheet(title: "标题", cancelButtonTitle: "取消", buttonTitles: ["选择1", "选择2", "选择3"])
            sheetView.show()
            // 获取点击事件
            sheetView.clickIndexClosure { (index) in
                if index == 0 {
                    print("点击了取消按钮")
                }else {
                    print("点击了按钮" + "\(index)")
                }
            }
        }
    }
}
