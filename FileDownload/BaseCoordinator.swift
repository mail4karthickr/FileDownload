//
//  BaseCoordinator.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 2/28/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import Foundation
import RxSwift

class BaseCoordinator<ResultType> {
    
    typealias CoordinationResult = ResultType
    
    let disposeBag = DisposeBag()
    
    let identifier = UUID()
    
    private var childCoordinators = [UUID: Any]()
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start().do(onNext: { [weak self] _ in
            self?.free(coordinator: coordinator)
        })
    }
    
    func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}
