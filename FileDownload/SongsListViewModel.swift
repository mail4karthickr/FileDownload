//
//  SongsListViewModel.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 2/27/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SongsListViewModel {
    var tracks: Driver<[Track]>
    var searchTerm: AnyObserver<String>
    var showSpinner: Driver<Bool>
    
    init(networkManager: NetworkManager = NetworkManager()) {
        let searchTermResultSubject = PublishSubject<String>()
        searchTerm = searchTermResultSubject.asObserver()
        
        let result = searchTermResultSubject
            .flatMapLatest { networkManager.getSearchResults(searchTerm: $0) }
        
        tracks = result
            .filter { $0.isSuccess }
            .map { $0.value!.results }
            .asDriver(onErrorJustReturn: [])
        
        showSpinner = Observable.merge(searchTermResultSubject.map { _ in true },
                                       result.map { _ in false })
                                .asDriver(onErrorJustReturn: false)
    }
}
