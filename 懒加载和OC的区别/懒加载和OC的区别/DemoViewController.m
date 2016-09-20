//
//  DemoViewController.m
//  懒加载和OC的区别
//
//  Created by 张丁豪 on 16/9/20.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DemoViewController

-(UILabel *)label{
    
    // 如果不存在就创建
    if (_label == nil) {
        
        _label = [[UILabel alloc]init];
        
        _label.text = @"Hello World";
        [_label sizeToFit];
        _label.center = self.view.center;
    }
    
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.label];
    
    // 释放
    _label = nil;
    
    // 会再次调用懒加载
    NSLog(@"%@",self.label);
}


@end
