//
//  AnimalManagementRouter.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import UIKit

class AnimalManagementRouter {
    
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        
        self.viewController = viewController
    }
    
    // DI
    static func assembleModules() -> UIViewController {
        
        guard let viewController = UIStoryboard(name: "AnimalManagementViewController", bundle: nil).instantiateInitialViewController() as? AnimalManagementViewController else {
            
            return UIViewController()
        }
        
        let router = AnimalManagementRouter(viewController: viewController)
        let interactor = AnimalManagementInteractor()
        // PresenterはView, Interactor, Routerそれぞれ必要なので
        // 生成し、initの引数で渡す
        let presenter = AnimalManagementPresenter(interactor: interactor,
                                                  router: router,
                                                  viewController: viewController)
        // 各種Presenterを設定
        interactor.output = presenter
        viewController.presenter = presenter
        
        return viewController
    }
}

protocol AnimalManagementWireFrame {

}
