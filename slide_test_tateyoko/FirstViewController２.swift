//
//  firstViewController.swift
//  slide_test_tateyoko
//
//  Created by asia-quest on 2016/11/11.
//  Copyright © 2016年 asia-quest. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.cyan
        
        // ボタンを生成する.
        let startButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 150, height: 80))
        startButton.backgroundColor = UIColor.red
        startButton.layer.masksToBounds = true
        startButton.setTitle("START", for: .normal)
        startButton.layer.cornerRadius = 40.0
        startButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-200)
        startButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(startButton);
    }
    
    /*
     ボタンイベント.
     */
    internal func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義する.
        ViewController()
        
        // アニメーションを設定する.
        ViewController().modalTransitionStyle = .partialCurl
        
        // Viewの移動する.
        self.present(ViewController(), animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
