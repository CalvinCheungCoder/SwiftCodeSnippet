//
//  ViewController.swift
//  懒加载
//
//  Created by 张丁豪 on 16/9/20.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 初始化Label并分配空间,会提前创建，移动端开发延迟加载
    // -懒加载
    lazy var label: DemoLabel = DemoLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI(){
        
        // 解包，为了参与计算
        view.addSubview(label)
        
        label.text = "Hello"
        label.sizeToFit()
        label.center = view.center
    }

}

