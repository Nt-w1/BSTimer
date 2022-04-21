//
//  AnimalTimerCell.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/30.
//

import UIKit

class AnimalTimerCell: UICollectionViewCell {
    
    @IBOutlet weak var animalIcon: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    /// 残り時間
    var remainTime: Float?
    
    /// セルで表示している動物の種類
    var animalType: Animal?
    
    /// timerPathをのせるレイヤー
    let timerLayer = CAShapeLayer()
    
    /// ベースとなるgrayPathをのせるレイヤー
    let grayLayer = CAShapeLayer()
    
    /// ベジェ曲線の幅
    let lineWidth: CGFloat = 4.8
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        drawBaseBezierPath()
        drawTimerBezierLine()
        setTimerLabelText()
        initUserDefinedRuntimeAttributes()
    }
    
    /// セルの部品の表示/非表示
    /// - Parameter isStarted: 表示する場合のみ
    func setCellPartsIsStarted(isStarted: Bool) {
        
        // セルの円型タイマーのグリーンレイヤー
        // タイマー発火中は表示する
        self.timerLayer.isHidden = !isStarted
        
        // セルの円型タイマーのグレーレイヤー
        // タイマー発火中は表示する
        self.grayLayer.isHidden = !isStarted
        
        // セルの時間ラベル表示/非表示
        // タイマー発火中は表示する
        self.timerLabel.isHidden = !isStarted
        
        // タイマーのリセットボタン
        // タイマー発火中は表示する
        self.clearBtn.isHidden = !isStarted
        
        // セルのチェックマーク表示/非表示
        // タイマー発火中は非表示にする
        self.checkMarkImage.isHidden = isStarted
        
    }
    
    /// 動物アイコンのセット
    /// タイマー発火中の場合、グレースケール画像をセットする
    /// - Parameter isStarted: タイマーが発火中かどうか
    func setAnimalIconImage(isStarted: Bool) {
        
        self.animalIcon.image = self.animalType?.getImage(isGray: isStarted)
    }
    
    // MARK: private Methods
    
    /// タップジェスチャーの初期化
    func initTapGesture() {
        
        // タップジェスチャーの設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.clearBtn.addGestureRecognizer(tapGesture)
    }
    
    func initUserDefinedRuntimeAttributes() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
    
    /// クリアボタンの画像タップのイベント
    @objc private func tapGesture(_ sender: UITapGestureRecognizer) {
        
        // タイマーのリセット
    }
    
    func reloadItems() {
        
        drawTimerBezierLine()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    /// タイマーのラベルをセット
    func setTimerLabelText() {
        
        guard let remainTime = remainTime else { return }
        self.timerLabel.text = timeToString(time: remainTime)
    }
    
    /// チェックマークの初期化
    func setCheckMarkImage() {
        
        self.checkMarkImage.image = UIImage(named: "check_mark")
    }
    
    /// ベジェ曲線の描画
    /// - Parameter remainTime: 残り時間
    func drawTimerBezierLine() {
        
        guard let remainTime = remainTime, let maxTime = animalType?.time else {
            
            return
        }
        
        // 残り時間を表す緑色のパス
        let timerPath: UIBezierPath = UIBezierPath()
        
        // 中心座標
        let centerPoint: CGPoint = CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0)
        
        // 半径
        let radius: CGFloat = self.frame.width / 2.0 - lineWidth * 2.0
        
        // 残り時間の比
        let timeRatio = CGFloat(maxTime - remainTime) / CGFloat(maxTime)
        
        // 開始角度
        // 残り時間(Float)を0.1秒ずつ経過させているが
        // 内部時間の分解能は0.1と近似された値であるため、timeRatioが1.0より大きい値を取ることがある
        // そのためtimeRatio <= 0.0の比較が必要となる
        let startAngle: CGFloat = timeRatio >= 1.0 ? 1.5 * .pi : -0.5 * .pi + 2.0 * .pi * timeRatio
        
        // 終了角度
        let endAngle: CGFloat = 1.5 * .pi

        // clockwise: Bool 時計/反時計回り
        timerPath.addArc(withCenter: centerPoint,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: true)
        
        timerLayer.path = timerPath.cgPath
        timerLayer.fillColor = UIColor.clear.cgColor
        timerLayer.strokeColor = UIColor(named: "timerGreen")?.cgColor
        timerLayer.lineWidth = lineWidth
        // 角丸
        timerLayer.lineCap = .round
        
        self.layer.addSublayer(timerLayer)
    }
    
    /// グレーのベジェ曲線の描画
    private func drawBaseBezierPath() {
        
        // ベースとなるグレーのパス
        let grayPath: UIBezierPath = UIBezierPath()
        
        // 中心座標
        let centerPoint: CGPoint = CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0)
        
        // 半径
        let radius: CGFloat = self.frame.width / 2.0 - lineWidth * 2.0
        
        
        // clockwise: Bool 時計/反時計回り
        grayPath.addArc(withCenter: centerPoint,
                        radius: radius,
                         startAngle: 0.0,
                         endAngle: 2 * .pi,
                        clockwise: true)
        
        grayLayer.path = grayPath.cgPath
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.strokeColor = UIColor(named: "timerBaseGray")?.cgColor
        grayLayer.lineWidth = lineWidth
        self.layer.addSublayer(grayLayer)
    }
    
    /// 整数型で渡された時間(秒)を文字列型の時間(n分n秒)の形にして返す
    /// - Parameter time: 整数型の時間(秒)
    /// - Returns: 文字列型の時間(n分n秒)
    private func timeToString(time: Float) -> String {
        
        // 小数点以下の切り上げをする
        let time = ceil(time)
        
        // 分数
        let min = Int(time / 60)
        
        // 秒数
        let sec = Int(time) % 60
        
        // 文字列の分数
        let strMin = String(min)
        
        // 文字列の秒数
        // 秒数が1桁の場合、10の位に0を足す
        let strSec = sec < 10 ? "0" + String(sec) : String(sec)
        
        let strTime = strMin + " : " + strSec
        
        return strTime
    }
}
