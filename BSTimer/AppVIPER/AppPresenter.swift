//
//  AppPresenter.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/03/31.
//

import Foundation

protocol AppPresentation: AnyObject {
    
    func didFinishLaunch()
}

final class AppPresenter {
    
    private let router: AppWireframe
    init(router: AppWireframe) {
        
        self.router = router
    }
}

extension AppPresenter: AppPresentation {
    
    func didFinishLaunch() {
        
        router.showAnimalManagementView()
    }
}
