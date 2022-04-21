//
//  AnimalManagementTimeEntity.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import Foundation

/// タイマーに表示する時間
struct AnimalManagementEntity {

    var minutes: Int
    var seconds: Int
    
    init(minutes: Int, seconds: Int) {
        
        self.minutes = minutes
        self.seconds = seconds
    }
    /// 自身の持っているタイマー時間をIntからStringに変換して返す
    /// - Returns: n分n秒の形で返す
    func timeIntegerToString() -> String {
        
        return String(self.minutes) + "分" + String(self.seconds) + "秒"
    }
    
}
