//
//  AnimalManagementPresenter.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import Foundation
import UIKit

/// Viewで発生したイベントを受け取るメソッド
protocol AnimalManagementPresentation {
    
    /// ライフサイクルのviewWillAppearのとき
    func viewWillAppear()
    
    /// タイマーが押されたとき
    func timerBtnDidPush(animalType: Animal)
    
    /// リセットボタンが押されたとき
    func onTapTimerResetBtn(animaType: Animal)
    
    /// 動物管理の時間を要求されたとき
    func getAnimalManageTime(animalType: Animal) -> Float
    
    /// タイマーが発火しているかどうかを要求されたとき
    /// - Returns: タイマーが発火している場合のみTrueを返す
    func isTimerStarted(animalType: Animal) -> Bool
}

/// 動物管理タイマーのInteractorからEntityを受け取るメソッド
protocol AnimalManagementInteractorOutput {
    
    /// タイマーが進んだときにセルの指定パスと残り時間を受け取る
    func advancedTimer(animalType: Animal)
    
    /// タイマーが終了したとき
    func endTimer(animalType: Animal)
}

class AnimalManagementPresenter {
    
    private let interactor: AnimalManagementInteractor
    private let router: AnimalManagementRouter
    private let viewController: AnimalManagementViewController
    
    init(interactor: AnimalManagementInteractor,
         router: AnimalManagementRouter,
         viewController: AnimalManagementViewController){
        
        self.interactor = interactor
        self.router = router
        self.viewController = viewController
    }
}

// MARK: - Presentation
extension AnimalManagementPresenter: AnimalManagementPresentation {
    
    /// ライフサイクルのViewWillAppearのタイミング
    func viewWillAppear() {
        
        interactor.generateAnimalManageTimer()
    }
    
    /// タイマーが押されたとき、Interactorにタイマーの発火を依頼する
    /// - Parameters:
    ///   - animalType: 管理対象の動物種類
    func timerBtnDidPush(animalType: Animal) {
        
        interactor.startAnimalManageTimer(animalType: animalType)
    }
    
    /// リセットボタンが押されたとき
    /// - Parameters:
    ///   - animaType: 押されたリセットの動物種類
    func onTapTimerResetBtn(animaType: Animal) {
        
        interactor.resetTimer(animalType: animaType)
    }
    
    /// 動物管理の時間を要求されたとき
    /// - Parameter animalType: 管理する動物の種類
    /// - Returns: 残り時間
    func getAnimalManageTime(animalType: Animal) -> Float {
        
        return interactor.getCurrentTime(animalType: animalType)
    }
    
    /// タイマーが発火しているかどうかを要求されたとき
    /// - Parameter animalType: 確認したいタイマーの動物種類
    /// - Returns: タイマーが発火している場合のみTrueを返す
    func isTimerStarted(animalType: Animal) -> Bool {
        
        return interactor.isTimerStarted(animalType: animalType)
    }
}

// MARK: - Interactor Output
extension AnimalManagementPresenter: AnimalManagementInteractorOutput {
    
    /// タイマーが進んだときに更新すべきセルの動物種類を受け取る
    /// - Parameters:
    ///   - animalType: 動物の種類
    func advancedTimer(animalType: Animal) {
        
        let indexPath = IndexPath(row: animalType.rawValue, section: 0)
        viewController.reloadViewCell(indexPath: indexPath)
    }
    
    /// タイマーが終了したときにタイマーの動物種類を受け取る
    /// - Parameter animalType: 動物の種類
    func endTimer(animalType: Animal) {
        
        let indexPath = IndexPath(row: animalType.rawValue, section: 0)
        viewController.reloadViewCell(indexPath: indexPath)
    }
}
