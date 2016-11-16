//
//  CustomActionSheet.swift
//  CustomAlert
//
//  Created by CalvinCheung on 16/11/16.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

import UIKit

class CustomActionSheet: UIView {

    // 声明闭包，点击按钮传值
    typealias clickSheetClosure = (_ index: Int) -> Void
    // 把申明的闭包设置成属性
    var clickClosure: clickSheetClosure?
    // 为闭包设置调用函数
    func clickIndexClosure(_ closure:clickSheetClosure?){
        // 将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    let backGroundView = UIView() // 背景视图
    let tap = UITapGestureRecognizer() // 手势
    
    init(title: String?, cancelButtonTitle: String?, buttonTitles: [String]?) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        if buttonTitles == nil || buttonTitles?.count == 0 {
            return
        }
        // 自定义一个actionsheet
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        // 添加手势
        tap.addTarget(self, action: #selector(self.removeWindowsView(_:)))
        self.addGestureRecognizer(tap)
        // 选择视图
        var num = 0
        if title != nil && title != "" { //是否添加标题
            num += 1
            // 加标题
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screen_width - 12, height: 50))
            titleLabel.textAlignment = .center
            titleLabel.text = title
            titleLabel.textColor = UIColor.gray
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            backGroundView.addSubview(titleLabel)
        }
        if cancelButtonTitle != nil && cancelButtonTitle != "" {
            num += 1
        }
        let height = 50 * (buttonTitles!.count + num)
        backGroundView.frame = CGRect(x: 6, y: screen_height, width: screen_width - 12, height: CGFloat(height))
        backGroundView.backgroundColor = UIColor.white
        backGroundView.layer.cornerRadius = 4
        backGroundView.clipsToBounds = true
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.addSubview(backGroundView)
        
        // 添加按键
        for index in 0..<buttonTitles!.count {
            let btn = SheetButton(frame: CGRect(x: 0, y: 50 * CGFloat(index + (title == nil || title == "" ? 0 : 1)), width: screen_width - 12, height: 50))
            btn.addTarget(self, action:  #selector(self.actionSheetButton(_:)), for: .touchUpInside)
            btn.addTarget(self, action:  #selector(self.actionSheetDowmAction(_:)), for: .touchDown)
            btn.tag = index + 1
            btn.setTitle(buttonTitles![index], for: UIControlState())
            btn.setTitleColor(UIColor.gray, for: UIControlState())
            backGroundView.addSubview(btn)
        }
        // cancelButton
        if cancelButtonTitle != nil && cancelButtonTitle != "" { //是否添加取消按钮
            let cancelBtn = UIButton(frame: CGRect(x: 8, y: CGFloat(height) - 44, width: screen_width - 28, height: 38))
            cancelBtn.addTarget(self, action: #selector(self.actionSheetButton(_:)), for: .touchUpInside)
            cancelBtn.addTarget(self, action:  #selector(self.actionSheetDowmAction(_:)), for: .touchDown)
            cancelBtn.layer.cornerRadius = 3
            cancelBtn.clipsToBounds = true
            cancelBtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            cancelBtn.layer.borderWidth = 1
            cancelBtn.setTitleColor(UIColor.red, for: UIControlState())
            cancelBtn.backgroundColor = UIColor.groupTableViewBackground
            cancelBtn.setTitle(cancelButtonTitle, for: UIControlState())
            backGroundView.addSubview(cancelBtn)
        }
        
    }
    
    func actionSheetButton(_ sender:UIButton) {
        if (clickClosure != nil) {
            clickClosure!(sender.tag)
        }
        dismiss()
    }
    
    func actionSheetDowmAction(_ sender:UIButton) {
        if sender.tag == 0 {
            sender.alpha = 0.6
            return
        }
        sender.backgroundColor = UIColor.orange
    }
    
    func removeWindowsView(_ thetap:UITapGestureRecognizer) {
        dismiss()
    }
    
    func show() {
        UIApplication.shared.windows[0].addSubview(self)
        UIView.animate(withDuration: 0.25, animations: {
            self.backGroundView.frame = CGRect(x: 6, y: self.screen_height -  self.backGroundView.frame.size.height - 8, width: self.screen_width - 12, height: self.backGroundView.frame.size.height)
            self.backgroundColor = UIColor(white: 0, alpha: 0.2)
        })
    }
    
    func dismiss() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2.0, animations: {
                self.backGroundView.frame = CGRect(x: self.backGroundView.frame.origin.x, y: self.screen_height, width: self.backGroundView.frame.size.width, height: self.backGroundView.frame.size.height)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2.0, relativeDuration: 1/2.0, animations: {
                self.backgroundColor = UIColor(white: 0, alpha: 0)
            })
        }) { (finished) in
            self.backGroundView.removeFromSuperview()
            self.removeFromSuperview()
            self.removeGestureRecognizer(self.tap)
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class SheetButton: UIButton {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(CGLineCap.round
        );
        context?.setLineWidth(0.5);  //线宽
        context?.setAllowsAntialiasing(true);
        context?.setStrokeColor(red: 220.0 / 255.0, green: 220.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0);  //线的颜色
        context?.beginPath();
        
        context?.move(to: CGPoint(x: 0, y: self.frame.size.height - 0.5));  //起点坐标
        context?.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - 0.5));   //终点坐标
        
        context?.strokePath();
    }


}
