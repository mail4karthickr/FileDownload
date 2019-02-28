//
//  NetworkManager.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 2/26/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional
import SwiftyJSON

enum Result<Value, Error: NetworkManagerError> {
    case success(Value)
    case failure(Error)
}

class NetworkManager {
    
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getSearchResults(searchTerm: String) -> Observable<Result<TrackGroup, NetworkManagerError>> {
        let url = URL(string: "https://itunesdd.apple.com/search/media=music&entity=song&term=\(searchTerm)")!
        return session.rx
            .json(url: url)
            .map { response -> Result<TrackGroup, NetworkManagerError> in
                do {
                    let responseData = try JSON(response).rawData()
                    let object = try JSONDecoder().decode(TrackGroup.self, from: responseData)
                    return .success(object)
                } catch {
                    return .failure(.networkError(error))
                }
            }
            .catchError({ error in
                return .just(.failure(.networkError(error)))
            })
    }
}

enum NetworkManagerError: Error {
    case networkError(Swift.Error)
}
