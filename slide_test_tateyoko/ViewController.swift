//
//  ViewController.swift
//  slide_test_tateyoko
//
//  Created by asia-quest on 2016/11/10.
//  Copyright © 2016年 asia-quest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    
    var userDefaults = UserDefaults.standard
    
    private var pageControl0: UIPageControl!
    private var pageControl1: UIPageControl!
    private var pageControl2: UIPageControl!
    private var pageControl3: UIPageControl!
    private var pageControl4: UIPageControl!
    
    private var scrollView: UIScrollView!
    
    private var showLabel: UILabel!
    private var findLabel: UILabel!
    
    private var showView: UIView!
    
    var startTime:TimeInterval!
    
    internal var time : Float = 0
    internal var playTime : String = ""
    //internal var startTime : NSDate!
    internal var nowTime : NSDate!
    
    var timeLabel : UILabel!
    var timer : Timer!
    
    // 配列の定義
    private var randomArray: [String] = ["","1","2","3","4","5","6","7","8","9","10","","","","",""]
    
    var gameCount:Int = 1
    let finishedCount: Int = 11
    
    //top5の配列の定義
    internal var currentRecord: [TimeInterval] = []

    
    override func viewDidLoad() {
        
        // 開始時間を取得
        startTime = NSDate.timeIntervalSinceReferenceDate
        
        
        // タイマーを設定する
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        
        // ビューの縦、横のサイズを取得する.
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        
        // 背景の色をCyanに設定する.
        self.view.backgroundColor = UIColor.cyan
        
        // ScrollViewを取得する.
        scrollView = UIScrollView(frame: self.view.frame)
        
        // ページ数を定義する.
        let rowSize = 4
        let lineSize = 4
        
        // 現在ページに０
        currentPage = 0
        
        // 縦方向と、横方向のインディケータを非表示にする.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // ページングを許可する.
        scrollView.isPagingEnabled = true
        
        // ScrollViewのデリゲートを設定する.
        scrollView.delegate = self
        
        // スクロールの画面サイズを指定する.
        scrollView.contentSize = CGSize(width: CGFloat(rowSize) * width, height: CGFloat(lineSize) * height)
        // スクロール方向を固定する
        scrollView.isDirectionalLockEnabled = true
        
        // ScrollViewをViewに追加する.
        self.view.addSubview(scrollView)
        
        randomArray.shuffle(count: randomArray.count)
        print(randomArray)
        // for文のループ回数を格納する変数
        var count: Int = 0
        
        
        for j in 0 ..< lineSize {
            
        // 行の数分、横ボタンを生成する.
            for i in 0 ..< rowSize {
                
                // ページごとに異なるラベルを生成する.
                let myLabel:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: CGFloat(j) * height + height/4 - 40, width: 80, height: 80))
                myLabel.backgroundColor = UIColor.black
                myLabel.textColor = UIColor.white
                myLabel.textAlignment = NSTextAlignment.center
                myLabel.layer.masksToBounds = true
                //ラベルに配列のcount番目の数字をおく
                myLabel.text = String(randomArray[count])
                myLabel.font = UIFont.systemFont(ofSize: 30)
                myLabel.layer.cornerRadius = 40.0
            
                scrollView.addSubview(myLabel)
                count += 1
            }
        }
        
        // 現在までの数字を表示するlabelを作成
        // サイズ、位置
        showLabel = UILabel(frame: CGRect(x: self.view.frame.maxX / 2, y: self.view.frame.maxY / 2, width: width / 2, height: self.view.frame.maxY / 2))
        // 背景色
        showLabel.backgroundColor = UIColor.white
        // 中央揃え
        showLabel.textAlignment = NSTextAlignment.center
        // ラベル文字サイズ、フォント
        showLabel.font = UIFont.systemFont(ofSize: 30)
        showLabel.text = "START"
        // 次の番号ならラベルに表示
        if (gameCount == Int(randomArray[currentPage])) {
            showLabel.font = UIFont.systemFont(ofSize: 100)
            showLabel.text = String(randomArray[currentPage])
            
            gameCount += 1
        }
        self.view.addSubview(showLabel)
        
        // タイム表示
        timeLabel = UILabel(frame: CGRect(x: self.view.frame.maxX / 2, y: self.view.frame.maxY * 7 / 8, width: width / 2, height: self.view.frame.maxY / 8))
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(timeLabel)
        self.view.bringSubviewToFront(timeLabel)
        
        // pageControl0を作成
        pageControl0 = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY / 2, width: width / 2, height: (self.view.frame.maxY / 2) / CGFloat(lineSize + 1)))
        pageControl0.backgroundColor = UIColor.orange
        
        // PageControlするページ数を設定する.
        pageControl0.numberOfPages = rowSize
        
        pageControl0.isUserInteractionEnabled = false
        
        self.view.addSubview(pageControl0!)

        // pageControl1を作成
        pageControl1 = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY / 2 + (self.view.frame.maxY / 2) / CGFloat(lineSize + 1), width: width / 2, height: (self.view.frame.maxY / 2) / CGFloat(lineSize + 1)))
        pageControl1.backgroundColor = UIColor.orange
        
        // PageControlするページ数を設定する.
        pageControl1.numberOfPages = rowSize
        
        pageControl1.isUserInteractionEnabled = false
        
        // ドットの初期設定の色を変更（隠す）
        pageControl1.currentPageIndicatorTintColor = UIColor(white: 1.0, alpha: 0.2)
        
        self.view.addSubview(pageControl1)
        
        // pageControl2を作成
        pageControl2 = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY / 2 + 2 * (self.view.frame.maxY / 2) / CGFloat(lineSize + 1), width: width / 2, height: (self.view.frame.maxY / 2) / CGFloat(lineSize + 1)))
        pageControl2.backgroundColor = UIColor.orange
        
        // PageControlするページ数を設定する.
        pageControl2.numberOfPages = rowSize
        
        pageControl2.isUserInteractionEnabled = false
        
        // ドットの初期設定の色を変更（隠す）
        pageControl2.currentPageIndicatorTintColor = UIColor(white: 1.0, alpha: 0.2)
        
        self.view.addSubview(pageControl2)

        // pageControl3を作成
        pageControl3 = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY / 2 + 3 * (self.view.frame.maxY / 2) / CGFloat(lineSize + 1), width: width / 2, height: (self.view.frame.maxY / 2) / CGFloat(lineSize + 1)))
        pageControl3.backgroundColor = UIColor.orange
        
        // PageControlするページ数を設定する.
        pageControl3.numberOfPages = rowSize
        
        pageControl3.isUserInteractionEnabled = false
        
        // ドットの初期設定の色を変更（隠す）
        pageControl3.currentPageIndicatorTintColor = UIColor(white: 1.0, alpha: 0.2)
        
        self.view.addSubview(pageControl3)
        
        // リセットボタンの作成
        let replayButton: UIButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.maxY / 2 + 4 * (self.view.frame.maxY / 2) / CGFloat(lineSize + 1), width: width / 2, height: (self.view.frame.maxY / 2) / CGFloat(lineSize + 1)))
        replayButton.backgroundColor = UIColor.red
        replayButton.setTitle("RESTART", for: .normal)
        replayButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        self.view.addSubview(replayButton)
        
    }
    
    @objc func onClickMyButton(sender: UIButton){
        //FirstViewControllerのインスタンスを生成
        let vc = FirstViewController()
        
        vc.modalPresentationStyle = .fullScreen
        // Viewの移動する.
        self.present(vc, animated: true, completion: nil)
    }

    
    var currentPage:Int = 0
    
    
    // ページがスクロールされた時
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width
        let pageHeight = scrollView.frame.size.height
        
        
        
        // dotの色の定義
        let otherPageColor = UIColor(white: 1.0, alpha: 0.2)
        
        if (scrollView.contentOffset.y == 0) {
            if fmod(scrollView.contentOffset.x , pageWidth) == 0 {
                //現在ページを表示する
                pageControl0.currentPageIndicatorTintColor = UIColor.white
                pageControl0.currentPage = Int(scrollView.contentOffset.x / pageWidth)
                
                // 現在ページを格納
                currentPage = Int((scrollView.contentOffset.x) / (scrollView.bounds.size.width))
                // 次の番号ならラベルに表示
                if (gameCount == Int(randomArray[currentPage])) {
                    showLabel.font = UIFont.systemFont(ofSize: 100)
                    showLabel.text = String(randomArray[currentPage])
                    gameCount += 1
                    if (gameCount == finishedCount) {
                        timeStop()
                        goToFinish()
                    }
                }
                print(currentPage)
            }
        
        }
        else {
            // currentPageの丸の色を隠す
            pageControl0.currentPageIndicatorTintColor = otherPageColor
        }
        
        if (scrollView.contentOffset.y == pageHeight) {
            if fmod(scrollView.contentOffset.x , pageWidth) == 0 {
                //現在ページを表示する
                pageControl1.currentPageIndicatorTintColor = UIColor.white
                pageControl1.currentPage = Int(scrollView.contentOffset.x / pageWidth)
                
                // 現在ページを格納
                currentPage = Int((scrollView.contentOffset.x) / (scrollView.bounds.size.width)) + 4
                // 次の番号ならラベルに表示
                if (gameCount == Int(randomArray[currentPage])) {
                    showLabel.font = UIFont.systemFont(ofSize: 100)
                    showLabel.text = String(randomArray[currentPage])
                    gameCount += 1
                    if (gameCount == finishedCount) {
                        timeStop()
                        goToFinish()
                    }
                }
                print(currentPage)
            }
        }
        else {
            // currentPageの丸の色を隠す
            pageControl1.currentPageIndicatorTintColor = otherPageColor
        }
        
        if (scrollView.contentOffset.y == pageHeight * 2) {
            if fmod(scrollView.contentOffset.x , pageWidth) == 0 {
                //現在ページを表示する
                pageControl2.currentPageIndicatorTintColor = UIColor.white
                pageControl2.currentPage = Int(scrollView.contentOffset.x / pageWidth)
                
                // 現在ページを格納
                currentPage = Int((scrollView.contentOffset.x) / (scrollView.bounds.size.width)) + 8
                // 次の番号ならラベルに表示
                if (gameCount == Int(randomArray[currentPage])) {
                    showLabel.font = UIFont.systemFont(ofSize: 100)
                    showLabel.text = String(randomArray[currentPage])
                    gameCount += 1
                    if (gameCount == finishedCount) {
                        timeStop()
                        goToFinish()
                    }
                    
                }
                print(currentPage)
            }
        }
        else {
            // currentPageの丸の色を隠す
            pageControl2.currentPageIndicatorTintColor = otherPageColor
        }
        
        if (scrollView.contentOffset.y == pageHeight * 3) {
            if fmod(scrollView.contentOffset.x , pageWidth) == 0 {
                //現在ページを表示する
                pageControl3.currentPageIndicatorTintColor = UIColor.white
                pageControl3.currentPage = Int(scrollView.contentOffset.x / pageWidth)
                
                // 現在ページを格納
                currentPage = Int((scrollView.contentOffset.x) / (scrollView.bounds.size.width)) + 12
                // 次の番号ならラベルに表示
                if (gameCount == Int(randomArray[currentPage])) {
                    showLabel.font = UIFont.systemFont(ofSize: 100)
                    showLabel.text = String(randomArray[currentPage])
                    gameCount += 1
                    if (gameCount == finishedCount) {
                        timeStop()
                        goToFinish()
                    }
                }
                print(currentPage)
            }
        }
        else {
            // currentPageの丸の色を隠す
            pageControl3.currentPageIndicatorTintColor = otherPageColor
        }

    }
    
    internal func goToFinish(){
        
        let fvc:FinishViewController = FinishViewController()
        fvc.playTime = self.playTime
        userDefaults.set(self.playTime, forKey:"NowTime")
        // アニメーションを設定する.
        fvc.modalPresentationStyle = .fullScreen
        
        // Viewの移動する.
        self.present(fvc, animated: true, completion: nil)

    }
    
    // タイマーから設定した時間毎に呼び起こされる関数
    @objc internal func onUpdate(timer : Timer){
        // 現在時刻の取得
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        // 現在時間と開始時間との差分
        let difftime: TimeInterval = currentTime - startTime
        
        //桁数を指定して文字列を作る.
        playTime = "Time: ".appendingFormat("%07.2f",difftime).appendingFormat(" s")
        timeLabel.text = playTime
    }
    
    // 終了時間で止める関数
    internal func timeStop() {
        if timer.isValid == true {
            
            //timerを破棄する.
            timer.invalidate()
            
        }
        else{
            
            //timerを生成する.
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
            
        }
    }
    
}
