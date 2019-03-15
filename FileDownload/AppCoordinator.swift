//
//  AppCoordinator.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 3/14/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let songsListCoordinator = SongsListCoordinator(window: window)
        return coordinate(to: songsListCoordinator)
    }
}
