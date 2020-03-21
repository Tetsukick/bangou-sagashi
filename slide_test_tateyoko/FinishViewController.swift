//
//  FinishViewController.swift
//  slide_test_tateyoko
//
//  Created by asia-quest on 2016/11/16.
//  Copyright © 2016年 asia-quest. All rights reserved.
//

import Foundation
import UIKit

class FinishViewController: UIViewController {
    
    internal var nameTextField: UITextField!
    internal var playTime : String!
    var userDefaults = UserDefaults.standard
    // 配列の宣言
    internal var rankings: [String] = []
    
    var ranking1Label: UILabel!
    var ranking2Label: UILabel!
    var ranking3Label: UILabel!
    var ranking4Label: UILabel!
    var ranking5Label: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.cyan
        
        //finishlabelを作成する.
        let finishLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        finishLabel.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 8)
        finishLabel.font = UIFont.systemFont(ofSize: 50)
        finishLabel.textAlignment = NSTextAlignment.center
        finishLabel.text = "FINISH !"
        self.view.addSubview(finishLabel)
        
        //タイム表示
        let timeLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 80))
        timeLabel.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 5)
        timeLabel.font = UIFont.systemFont(ofSize: 35)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.text = playTime
        self.view.addSubview(timeLabel)
        // ボタンを生成する.
        let playButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 150, height: 80))
        playButton.backgroundColor = UIColor.red
        playButton.layer.masksToBounds = true
        playButton.setTitle("PLAY AGAIN", for: .normal)
        playButton.layer.cornerRadius = 40.0
        playButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-200)
        playButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        
        let mask:UIButton = UIButton(frame:CGRect(x: 0,y: 0, width: 1500, height: 8000))
        mask.addTarget(self, action: #selector(onClickMyButton2(sender:)), for: .touchUpInside)
        self.view.addSubview(mask)
        
        // ボタンを追加する.
        self.view.addSubview(playButton);
        
        // userDefaultが空か確認
        if((userDefaults.object(forKey: "ranking")) != nil){
            // 配列rankingに過去のランキングを追加
            rankings = userDefaults.object(forKey: "ranking") as! [String]
            if (rankings.count < 5) {
                goToInputName()
            }
            else if (rankings[4] > self.playTime ) {
                goToInputName()
            }
        }
        else {
            goToInputName()
        }
        
        //配列の中身をリセット（初期起動時用）
//        reflesh()
        
        // ランキングラベルの作成
        if rankings.count >= 1 {
            ranking1Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
            ranking1Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 80)
            ranking1Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
            ranking1Label.text = "1位 ".appendingFormat(rankings[0])
            ranking1Label.isUserInteractionEnabled = false
            self.view.addSubview(ranking1Label)
        }
        
        if rankings.count >= 2 {
            ranking2Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
            ranking2Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 60)
            ranking2Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
            ranking2Label.text = "2位 ".appendingFormat(rankings[1])
            ranking2Label.isUserInteractionEnabled = false
            self.view.addSubview(ranking2Label)
        }
        
        if rankings.count >= 3 {
            ranking3Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
            ranking3Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 40)
            ranking3Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
            ranking3Label.text = "3位 ".appendingFormat(rankings[2])
            ranking3Label.isUserInteractionEnabled = false
            self.view.addSubview(ranking3Label)
        }
        
        if rankings.count >= 4 {
            ranking4Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
            ranking4Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 20)
            ranking4Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
            ranking4Label.text = "4位 ".appendingFormat(rankings[3])
            ranking4Label.isUserInteractionEnabled = false
            self.view.addSubview(ranking4Label)
        }
        
        if rankings.count >= 5 {
            ranking5Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
            ranking5Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) )
            ranking5Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
            ranking5Label.text = "5位 ".appendingFormat(rankings[4])
            ranking5Label.isUserInteractionEnabled = false
            self.view.addSubview(ranking5Label)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        print(rankings.count)
        
        if((userDefaults.object(forKey: "ranking")) != nil){
            rankings = userDefaults.object(forKey: "ranking") as! [String]

            if (ranking1Label != nil) {
                ranking1Label.text = "1位 ".appendingFormat(rankings[0])
            }
            else if rankings.count >= 1 {
                ranking1Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
                ranking1Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 80)
                ranking1Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
                ranking1Label.text = "1位 ".appendingFormat(rankings[0])
                ranking1Label.isUserInteractionEnabled = false
                self.view.addSubview(ranking1Label)
            }
            
            if (ranking2Label != nil) {
                ranking2Label.text = "2位 ".appendingFormat(rankings[1])
            }
            else if rankings.count >= 2 {
                ranking2Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
                ranking2Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 60)
                ranking2Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
                ranking2Label.text = "2位 ".appendingFormat(rankings[1])
                ranking2Label.isUserInteractionEnabled = false
                self.view.addSubview(ranking2Label)
            }
            
            if (ranking3Label != nil) {
                ranking3Label.text = "3位 ".appendingFormat(rankings[2])
            }
            else if rankings.count >= 3 {
                ranking3Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
                ranking3Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 40)
                ranking3Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
                ranking3Label.text = "3位 ".appendingFormat(rankings[2])
                ranking3Label.isUserInteractionEnabled = false
                self.view.addSubview(ranking3Label)
            }

            
            if (ranking4Label != nil) {
                ranking4Label.text = "4位 ".appendingFormat(rankings[3])
            }
            else if rankings.count >= 4 {
                ranking4Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
                ranking4Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) - 20)
                ranking4Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
                ranking4Label.text = "4位 ".appendingFormat(rankings[3])
                ranking4Label.isUserInteractionEnabled = false
                self.view.addSubview(ranking4Label)
            }

            
            if (ranking5Label != nil) {
                ranking5Label.text = "5位 ".appendingFormat(rankings[4])
            }
            else if rankings.count >= 5 {
                ranking5Label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 20))
                ranking5Label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: (self.view.bounds.height / 2) )
                ranking5Label.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
                ranking5Label.text = "5位 ".appendingFormat(rankings[4])
                ranking5Label.isUserInteractionEnabled = false
                self.view.addSubview(ranking5Label)
            }

        }

        
    }
    
    /*
     ボタンイベント.
     */
    @objc internal func onClickMyButton(sender: UIButton){
        //FirstViewControllerのインスタンスを生成
        let vc = FirstViewController()
        vc.modalPresentationStyle = .fullScreen

        // Viewの移動する.
        self.present(vc, animated: true, completion: nil)
    }
    @objc internal func onClickMyButton2(sender: UIButton){
        print(2)
    }
    
    internal func goToInputName(){
        
        // secondViewControllerのインスタンス生成.
        let inputNameVC = InputNameViewController()
        
        // navigationControllerのrootViewControllerにsecondViewControllerをセット.
        let nav = UINavigationController(rootViewController: inputNameVC)
        nav.modalPresentationStyle = .fullScreen
        
        print("入ってるよー")
        
        DispatchQueue(label: "jp.classmethod.app.queue").async {
            DispatchQueue.main.async {
                // 画面遷移.
                self.present(nav, animated: true, completion: nil)
                
            }
        }
    }
    
    func reflesh() {
        userDefaults.set([], forKey:"ranking")
    }
    
    func appendArray() {
        //配列を並べ替え
        rankings.sort()
        print(rankings)
        // userDefaultsに保存
        userDefaults.set(rankings, forKey:"ranking")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
