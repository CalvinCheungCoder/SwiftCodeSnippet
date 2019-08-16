//
//  ViewController.swift
//  Fireworks
//
//  Created by Calvin on 2019/8/16.
//  Copyright © 2019 Calvin. All rights reserved.
//
// Base on szulctomasz blog: http://szulctomasz.com/programming-blog/2018/09/add-fireworks-and-sparks-to-a-uiview/

import UIKit

class ViewController: UIViewController {
    
    let btnWidth:CGFloat = 50.0
    let screenWidth:CGFloat = UIScreen.main.bounds.width
    let screenHeight:CGFloat = UIScreen.main.bounds.height
    
    var label:UILabel!
    var btn1:UIButton!
    var btn2:UIButton!
    var btn3:UIButton!
    
    private var correctSolutionIndex: Int = 0
    private let fireworkController = ClassicFireworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUI()
        self.refresh()
    }
    
    func setUI() {
        
        let titleLabel: UILabel!
        titleLabel = UILabel.init()
        titleLabel.frame = CGRect(x: 0.0, y: screenHeight/2-220, width: screenWidth, height: 50)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor = .gray
        titleLabel.text = "计算 2 个数之和"
        self.view.addSubview(titleLabel)
        
        label = UILabel.init()
        label.frame = CGRect(x: 0.0, y: screenHeight/2-100, width: screenWidth, height: 50)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = .black
        self.view.addSubview(label)
        
        let spacing:CGFloat = (screenWidth - 3 * btnWidth) / 4
        
        btn1 = UIButton.init()
        btn1.frame = CGRect(x: spacing, y: screenHeight/2+30.0, width: btnWidth, height: btnWidth)
        btn1.tag = 0
        btn1.style()
        btn1.addTarget(self, action: #selector(btnTapped), for:.touchUpInside)
        btn1.addTarget(self, action: #selector(buttonTouchedDown), for:.touchDown)
        btn1.addTarget(self, action: #selector(buttonTouchedUpOutside), for:.touchUpOutside)
        self.view.addSubview(btn1)
        
        btn2 = UIButton.init()
        btn2.frame = CGRect(x: spacing * 2 + btnWidth, y: screenHeight/2+30.0, width: btnWidth, height: btnWidth)
        btn2.tag = 1
        btn2.style()
        btn2.addTarget(self, action: #selector(btnTapped), for:.touchUpInside)
        btn2.addTarget(self, action: #selector(buttonTouchedDown), for:.touchDown)
        btn2.addTarget(self, action: #selector(buttonTouchedUpOutside), for:.touchUpOutside)
        self.view.addSubview(btn2)
        
        btn3 = UIButton.init()
        btn3.frame = CGRect(x: spacing * 3 + btnWidth * 2, y: screenHeight/2+30.0, width: btnWidth, height: btnWidth)
        btn3.tag = 2
        btn3.style()
        btn3.addTarget(self, action: #selector(btnTapped), for:.touchUpInside)
        btn3.addTarget(self, action: #selector(buttonTouchedDown), for:.touchDown)
        btn3.addTarget(self, action: #selector(buttonTouchedUpOutside), for:.touchUpOutside)
        self.view.addSubview(btn3)
    }
    
    @objc func btnTapped(sender: UIButton) {
        self.checkSolution(selection: sender.tag, correct: self.correctSolutionIndex, button: sender)
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc func buttonTouchedDown(sender: UIButton) {
        UIView.animate(withDuration: 0.05, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.92)
        }, completion: nil)
    }
    
    @objc func buttonTouchedUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func checkSolution(selection: Int, correct: Int, button: UIButton) {
        guard selection == correct else { return }
        
        self.fireworkController.addFireworks(count: 2, sparks: 8, around: button)
        self.refresh()
    }
    
    private func refresh() {
        let num1 = Int(arc4random_uniform(10))
        let num2 = Int(arc4random_uniform(10))
        
        let sol1 = num1 + num2
        var sol2 = sol1 + Int(arc4random_uniform(10)) - 5
        if sol2 == sol1 {
            sol2 += 1
        }
        
        var sol3 = sol1 + Int(arc4random_uniform(12)) - 4
        if sol3 == sol1 {
            sol3 -= 1
        }
        
        var solutions = [sol1, sol2, sol3]
        var shuffled = [Int]()
        
        for _ in 0..<solutions.count {
            let idx = Int(arc4random_uniform(UInt32(solutions.count)))
            shuffled.append(solutions[idx])
            solutions.remove(at: idx)
        }
        
        self.label.text = "\(num1) + \(num2) = ?"
        self.btn1.setTitle("\(shuffled[0])", for: .normal)
        self.btn2.setTitle("\(shuffled[1])", for: .normal)
        self.btn3.setTitle("\(shuffled[2])", for: .normal)
        self.correctSolutionIndex = shuffled.firstIndex(of: sol1)!
    }
}

extension UIButton {
    
    func style() {
        let color = UIColor(red:0.42, green:0.58, blue:0.98, alpha:1.00)
        self.backgroundColor = color
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 8
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.3
        
        let shadowWidth = layer.bounds.width * 0.9
        let shadowRect = CGRect(x: 0 + (layer.bounds.width - shadowWidth) / 2.0, y: 0, width: shadowWidth, height: layer.bounds.height)
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        
        layer.zPosition = 2
    }
}
