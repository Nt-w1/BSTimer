//
//  UIView+Extension.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import UIKit

extension UIView {
    
    func parentViewController() -> UIViewController? {
        
        var parentResponder: UIResponder? = self
        while true {
            
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }

    func parentView<T: UIView>(type: T.Type) -> T? {
        
        var parentResponder: UIResponder? = self
        while true {
            
            guard let nextResponder = parentResponder?.next else { return nil }
            if let view = nextResponder as? T {
                return view
            }
            parentResponder = nextResponder
        }
    }
}
