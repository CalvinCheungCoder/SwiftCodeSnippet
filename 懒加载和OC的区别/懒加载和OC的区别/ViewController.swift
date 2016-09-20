//
//  ViewController.swift
//  懒加载和OC的区别
//
//  Created by 张丁豪 on 16/9/20.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 和OC不同，懒加载只会在第一次调用的时候，执行闭包，然后将闭包保存在label的属性
    private lazy var label:UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        label.text = "Hello World"
        label.sizeToFit()
        
        print(label)
        
        // 释放
//        label = nil
        
        print(label)
    }



}

