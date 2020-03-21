//
//  Array+shuffled.swift
//  slide_test_tateyoko
//
//  Created by 菊池哲平 on 2016/11/12.
//  Copyright © 2016年 asia-quest. All rights reserved.
//

import Foundation

// 配列の拡張
extension Array {
    mutating func shuffle(count: Int) {
        for _ in 0..<count {
            self.sort { _,_ in arc4random() < arc4random() }
        }
    }
}


