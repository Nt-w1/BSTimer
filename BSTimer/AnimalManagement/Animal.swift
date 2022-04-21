//
//  Animal.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import Foundation
import UIKit

/// 管理対象の動物
enum Animal: Int, CaseIterable {
    
    case bear
    case gorilla
    case bloodHound
    case hounds
    case bat
    case crow
    case osprey
    
    /// 動物の初期時間
    var time: Float {
        
        switch self {
        case .bear, .gorilla:
            // クマゴリは2分50秒
            return 2.0 * 60.0 + 50.0
            
        case .bloodHound, .hounds:
            // ブラハ猟犬は2分20秒
            return 2.0 * 60.0 + 20.0
            
        case .bat, .crow, .osprey:
            // コウモリ、カラス、ミサゴは1分50秒
            return 1.0 * 60.0 + 50.0
        }
    }
    
    /// 動物の画像
    /// - Parameter size: 指定サイズ
    /// - Parameter isGray: グレースケール変換するか否か
    /// - Returns: 動物の画像を返す
    func getImage(isGray: Bool) -> UIImage {
        
        var animalImage: UIImage?
        
        switch self {
            
        case .bear:
            animalImage = isGray ? UIImage(named: "Animal_Bear_Gray") : UIImage(named: "Animal_Bear")
            
        case .gorilla:
            animalImage = isGray ? UIImage(named: "Animal_Gorilla_Gray") : UIImage(named: "Animal_Gorilla")
            
        case .bloodHound:
            animalImage = isGray ? UIImage(named: "Animal_BloodHound_Gray") : UIImage(named: "Animal_BloodHound")
            
        case .hounds:
            animalImage = isGray ? UIImage(named: "Animal_Hound_Gray") : UIImage(named: "Animal_Hound")
            
        case .bat:
            animalImage = isGray ? UIImage(named: "Animal_Bat_Gray") : UIImage(named: "Animal_Bat")
            
        case .crow:
            animalImage = isGray ? UIImage(named: "Animal_Crow_Gray") : UIImage(named: "Animal_Crow")
            
        case .osprey:
            animalImage = isGray ? UIImage(named: "Animal_Osprey_Gray") : UIImage(named: "Animal_Osprey")
        }
        
        guard let image = animalImage else { return UIImage() }
        return image
        
    }
}




