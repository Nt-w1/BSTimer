//
//  AnimalManagementViewController.swift
//  BSTimer
//
//  Created by 永瀬 on 2021/11/09.
//

import UIKit
import os

/// セルからのイベントをデリゲートで受け取る
protocol outputFromCellInput {
    
    /// CollectionViewCellがダブルタップされたとき
    func doubleTapCollectionViewCell()
}

/// 動物管理画面の機能制御
class AnimalManagementViewController: UIViewController {
    
    /// Presenterへのデリゲート
    var presenter: AnimalManagementPresentation? = nil
    
    /// セルの再利用時のID
    private let reuseIdentifier = "AnimalTimer"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: ライフサイクル viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setFlowLayout()
        // スクロールさせない
        collectionView.isScrollEnabled = false
    }
    
    // MARK: ライフサイクル viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    /// indexPathで指定したセルを更新する
    /// - Parameter indexPath: 指定したIndexPath
    func reloadViewCell(indexPath: IndexPath) {
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    /// CollectionViewFLowLayoutの設定
    private func setFlowLayout() {
        
        collectionViewFlowLayout.minimumInteritemSpacing = self.view.frame.width / 100
        collectionViewFlowLayout.minimumLineSpacing =  collectionViewFlowLayout.minimumInteritemSpacing
    }
    
    private func initCollectionViewCell() {
        
    }
    
    /// タイマー画面では回転をサポートしない
    override var shouldAutorotate: Bool {
     
        return false
    }
    
    @IBAction func onTapClearBtn(_ sender: UIButton) {
        
        guard let animalType = Animal.init(rawValue: sender.tag) else { return }
        presenter?.onTapTimerResetBtn(animaType: animalType)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AnimalManagementViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Animal.allCases.count
    }
    
    // セルの生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AnimalTimerCell, let animalType = Animal(rawValue: indexPath.row), let presenter = self.presenter else {
            
            return UICollectionViewCell()
        }
        
        // タイマーが発火しているかどうか
        let isStarted = presenter.isTimerStarted(animalType: animalType)
        
        // セルに動物の種類を渡す
        cell.animalType = animalType
        
        // セルにタグを設定する
        // ダブルタップジェスチャーでセルを識別するために使う
        cell.tag = animalType.rawValue
        
        // タイマーの残り時間
        cell.remainTime = presenter.getAnimalManageTime(animalType: animalType)
        
        // セルの動物イメージをセット
        cell.setAnimalIconImage(isStarted: isStarted)
        
        // セルのチェックマークイメージをセット
        cell.setCheckMarkImage()
        
        // セルの部品の表示/非表示
        cell.setCellPartsIsStarted(isStarted: isStarted)
        
        return cell
    }
    
    // セル押下時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let animalType = Animal(rawValue: indexPath.row) else { return }
        presenter?.timerBtnDidPush(animalType: animalType)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AnimalManagementViewController: UICollectionViewDelegateFlowLayout {
    
    // セルのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSide = collectionView.frame.width / 2.0 - collectionViewFlowLayout.minimumInteritemSpacing * 2.0
        
        return CGSize(width: cellSide, height: cellSide)
    }
    
    // CollectionViewの配置間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        let inset = collectionViewFlowLayout.minimumInteritemSpacing

        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
}
