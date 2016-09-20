//
//  DemoLabel.swift
//  懒加载
//
//  Created by 张丁豪 on 16/9/20.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class DemoLabel: UILabel {

    // 纯代码调用
    override init(frame:CGRect){
        super.init(frame: frame)
        
        setUpUI()
    }
    
    // xib调用
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        
        setUpUI()
        
    }

    private func setUpUI(){
        print("设置界面")
    }

}
