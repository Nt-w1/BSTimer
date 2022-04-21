//
//  AnimalManageInteractor.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/30.
//

import Foundation
import os

// MARK: - 動物管理タイマーの生成プロトコル
protocol AnimalManageUsecase: AnyObject {
    
    /// Presenterへの通知デリゲート
    var output: AnimalManagementInteractorOutput? { get set }
    
    /// タイマーの現在の時間の取得
    /// - Returns: 現在の時間
    func getCurrentTime(animalType: Animal) -> Float
    
    /// 動物タイマーの初期生成
    func generateAnimalManageTimer()
    
    /// タイマーの発火
    func startAnimalManageTimer(animalType: Animal)
    
    /// タイマーのリセット
    func resetTimer(animalType: Animal)
    
    /// タイマーが発火しているかどうかを返す
    /// - Returns: 発火している場合のみTrueを返す
    func isTimerStarted(animalType: Animal) -> Bool
}

// MARK: - 動物管理タイマーの通知プロトコル
protocol AnimalTimerOutput {
    
    /// タイマーが進んだとき
    func advancedTimer(animalType: Animal)
    
    /// タイマーが終了したとき
    func endTimer(animalType: Animal)
}

// MARK: - 動物管理タイマーのロジック
/// 管理対象の動物ごとにタイマーを生成する
final class AnimalManagementInteractor {
    
    /// PresenterにEntityを引き渡すためのデリゲート
    var output: AnimalManagementInteractorOutput?
    
    /// 動物ごとに割り振られたタイマーのリスト
    var timerList: [AnimalManagementTimer] = []
    
}

// MARK: - Presenterから依頼を受けてロジックを開始する
extension AnimalManagementInteractor: AnimalManageUsecase {
    
    /// 動物タイマーの初期生成
    func generateAnimalManageTimer() {
        
        Animal.allCases.forEach { animal in
            
            let timer = AnimalManagementTimer(animalType: animal, remainTime: animal.time)
            
            timer.outputToInteractor = self
            timerList.append(timer)
        }
    }
    
    /// 動物種別ごとのタイマー現在の時間を取得する
    /// - Parameter animalType: 動物種別
    /// - Returns: 現在の時間
    func getCurrentTime(animalType: Animal) -> Float {
        
        let startTimer = timerList[animalType.rawValue]
        return startTimer.getCurrentTime(animalType: animalType)
    }
    
    /// 指定された動物種別のタイマーを発火させる
    /// - Parameters:
    ///   - animaltype: 発火させたいタイマーの動物
    func startAnimalManageTimer(animalType: Animal) {
        
        let startTimer = timerList[animalType.rawValue]
        startTimer.startTimer()
    }
    
    /// タイマーのリセット
    /// - Parameter animalType: 動物の種類
    func resetTimer(animalType: Animal) {
        
        let startTimer = timerList[animalType.rawValue]
        startTimer.relocationTimer(completion: nil)
    }
    
    /// タイマーが発火しているかどうかを通知する
    /// - Parameter animalType: 動物の種類
    /// - Returns: 発火している場合のみTrueを返す
    func isTimerStarted(animalType: Animal) -> Bool {
        
        let startTimer = timerList[animalType.rawValue]
        return startTimer.isTimerStarted()
    }
}

// MARK: - Interactorの結果をPresenterに知らせる
extension AnimalManagementInteractor: AnimalTimerOutput {
    
    /// 動物管理タイマーが進んだことを知らせる
    /// - Parameters:
    ///   - time: 残り時間
    func advancedTimer(animalType: Animal) {
        
        output?.advancedTimer(animalType: animalType)
    }
    
    /// タイマーが終了したことを知らせる
    func endTimer(animalType: Animal) {
        
        output?.endTimer(animalType: animalType)
    }
}
