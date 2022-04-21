//
//  AnimalManagementTimer.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/04/01.
//

import Foundation

/// 動物ごとに生成されるタイマー
/// Interactorから生成されるクラス
/// タイマーが複数あるためPresenterからは直接呼ばれない
final class AnimalManagementTimer {
    
    /// Interactorに通知するデリゲート
    /// AnimalManagementTimerクラスは管理画面と同時に生成されるためPresenterのデリゲートを直接持てない
    weak var outputToInteractor: AnimalManagementInteractor?
    
    /// 動物管理タイマー
    private var timer: Timer?
    
    /// タイマーが発火しているかの状態
    private var isStarted: Bool = false
    
    /// 残り時間
    private var remainTime: Float
    
    /// 自身の動物種別
    private var animalType: Animal
    
    init(animalType: Animal, remainTime: Float) {
        
        self.animalType = animalType
        self.remainTime = remainTime
    }
}

extension AnimalManagementTimer {
    
    /// 指定された管理対象の動物の現在の時間を取得する
    /// - Parameter animalType: 管理対象の動物種類
    /// - Returns: 管理対象の動物の現在の時間
    func getCurrentTime(animalType: Animal) -> Float {
        
        return remainTime
    }
    
    /// タイマーの発火
    func startTimer() {
        
        // 二重にタイマーを発火させないため
        if isStarted { return }
        
        // タイマーが発火したのでTrueに
        self.isStarted = true
        
        // カウントダウン開始
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            
            // 0秒になった場合タイマーの破棄をする
            // 小数点第二位で四捨五入して0.0以下の場合を0.0秒とみなす
            if (round(self.remainTime * 10) / 10 <= 0.0) {
                
                // タイマーを破棄する
                // さらにタイマーを再度利用可能とするために初期設定をリセットする
                self.relocationTimer() {
                    
                    // タイマーが終了したことを知らせる
                    self.outputToInteractor?.endTimer(animalType: self.animalType)
                    
                    return
                }
                
                return
            }
            
            // 内部の残り時間を0.1秒ずつ経過させる
            self.remainTime -= 0.1
            
            // 残り時間をPresenterに知らせる
            self.outputToInteractor?.advancedTimer(animalType: self.animalType)
        })
    }
    
    /// タイマーの再配置
    /// 廃棄した後再利用可能とするために変数をリセットする
    /// - Parameters:
    ///   - callBack: タイマーの再配置後に必要な処理を記述する
    func relocationTimer(completion: (() -> ())?) {
        
        // 再度タイマーが押されていない状態となるのでフラグを戻す
        self.isStarted = false
        
        // タイマーの破棄
        self.timer?.invalidate()
        
        // 残り時間に初期時間を再セット
        self.remainTime = self.animalType.time
        
        guard let completion = completion else { return }
        // コールバックの処理
        completion()
    }
    
    /// タイマーが発火しているかどうかを返す
    /// - Returns: 発火している場合のみTrueを返す
    func isTimerStarted() -> Bool {
        
        return self.isStarted
    }
}
