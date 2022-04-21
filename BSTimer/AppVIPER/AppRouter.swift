//
//  AppRouter.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import UIKit

protocol AppWireframe: AnyObject {
    
    func showAnimalManagementView()
}

final class AppRouter {
    
    private let window: UIWindow
    
    private init(window: UIWindow) {
        
        self.window = window
    }
    
    static func assembleModules(window: UIWindow) -> AppPresentation {
        
        let router = AppRouter(window: window)
        let presenter = AppPresenter(router: router)
        
        return presenter
    }
}

extension AppRouter: AppWireframe {
    
    func showAnimalManagementView() {
        
        let rootViewController = AnimalManagementRouter.assembleModules()
       
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
    }
}
