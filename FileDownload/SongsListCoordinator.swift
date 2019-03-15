//
//  SongsListCoordinator.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 3/14/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import UIKit
import RxSwift

class SongsListCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = SongsListViewModel()
        let viewController = SongsListViewController.initFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}
