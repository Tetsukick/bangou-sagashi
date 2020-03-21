//
//  InputNameViewController.swift
//  slide_test_tateyoko
//
//  Created by asia-quest on 2016/11/17.
//  Copyright © 2016年 asia-quest. All rights reserved.
//

import Foundation
import UIKit

class InputNameViewController : UIViewController,UITextFieldDelegate{
    
    internal var nameTextField: UITextField!
    var userDefaults = UserDefaults.standard
    internal var playTime : String!
    internal var rankings: [String] = []
    var cautionLabel: UILabel!
    
    override func viewDidLoad() {
        
        let mColor = UIColor(white: 1.0, alpha: 0.6)
        self.view.backgroundColor = mColor
        
        // messageLabelの作成
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        messageLabel.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 5)
        messageLabel.font = UIFont.systemFont(ofSize: 35)
        messageLabel.textColor = UIColor.red
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.text = "ランクインしました！"
        self.view.addSubview(messageLabel)
        
        // messageLabel2の作成
        let messageLabel2: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        messageLabel2.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
        messageLabel2.font = UIFont.systemFont(ofSize: 20)
        messageLabel2.textColor = UIColor.white
        messageLabel2.textAlignment = NSTextAlignment.center
        messageLabel2.text = "名前を入力してください"
        self.view.addSubview(messageLabel2)

        
        // 完了Buttonを生成.
        let myButton = UIButton()
        myButton.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        myButton.backgroundColor = UIColor.red
        myButton.layer.masksToBounds = true
        myButton.setTitle("完了", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        myButton.layer.cornerRadius = 40.0
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height * 3/4)
        myButton.tag = 1
        myButton.addTarget(self, action: #selector(InputNameViewController.onClickMyButton(sender:)), for: .touchUpInside)
        
        // viewにButtonを追加.
        self.view.addSubview(myButton)
        
        // UITextFieldを作成する.
        nameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width * 4/5, height: 50))
        nameTextField.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        
        // 表示する文字を代入する.
        nameTextField.placeholder = "名前を入力してください(4文字まで)"
        
        // 枠を表示する.
        nameTextField.borderStyle = .roundedRect
        
        // クリアボタンを追加.
        nameTextField.clearButtonMode = .whileEditing
        
        //リターンキーの設定
        nameTextField.returnKeyType = UIReturnKeyType.done
        
        nameTextField.delegate = self
        
        // Viewに追加する
        self.view.addSubview(nameTextField)
        
        cautionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20))
        cautionLabel.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2 + 45)
        cautionLabel.font = UIFont.systemFont(ofSize: 18)
        cautionLabel.textColor = UIColor.red
        cautionLabel.textAlignment = NSTextAlignment.center
        cautionLabel.text = ""
        cautionLabel.textColor = UIColor.red
        self.view.addSubview(cautionLabel)

    }
    
    /*
     Buttonを押した時に呼ばれるメソッド.
     */
    @objc internal func onClickMyButton(sender : UIButton){
        
        // 文字数最大を決める.
        let maxLength: Int = 5
        
        // スペースをトリムする
        let str = nameTextField.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        
        // 文字数が4文字以下なら警告する.
        if str.count < maxLength {
            if (str == "") {
                nameTextField.placeholder = "名前を入力してください(4文字まで)"
                cautionLabel.text = "●名前を入力してください(4文字まで)"
                
            }
            else {
                if((userDefaults.object(forKey: "ranking")) != nil){
                    // 配列rankingにplaytimeを追加
                    rankings = userDefaults.object(forKey: "ranking") as! [String]
                }
                if((userDefaults.string(forKey: "NowTime")) != nil){
                    let time = userDefaults.string(forKey: "NowTime")
                    userDefaults.set(nameTextField.text, forKey:"NAME")
                    if((userDefaults.string(forKey: "NAME")) != nil){
                        let name = userDefaults.string(forKey: "NAME")
                        let str = time! + " , Name: ".appendingFormat(name!)
                        rankings.append(str)
                        //配列を並べ替え
                        rankings.sort()
                        print(rankings)
                        // userDefaultsに保存
                        userDefaults.set(rankings, forKey:"ranking")
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        }else {
            cautionLabel.text = "●名前を入力してください(4文字まで)"
        }
        
    }
    
    
    /*
     UITextFieldが編集された直前に呼ばれる
     */
    internal func textFieldDidBeginEditing(_ TextField: UITextField) {
        print("textFieldDidBeginEditing: \(nameTextField.text!)")
        if (cautionLabel != nil) {
            cautionLabel.text = ""
        }
    }
    
    /*
     UITextFieldが編集された直後に呼ばれる
     */
    internal func textFieldDidEndEditing(_ TextField: UITextField) {
        print("textFieldDidEndEditing: \(nameTextField.text!)")
    }
    
    /*
     改行ボタンが押された際に呼ばれる
     */
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(nameTextField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        nameTextField.resignFirstResponder()
        
        print("完了")
        return true
    }
}
