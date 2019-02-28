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

enum Result<Value, NetworkManagerError: Swift.Error> {
    case success(Value)
    case failure(NetworkManagerError)
    
    var isSuccess: Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
    
    var value: Value? {
        switch self {
        case .success(let result):
            return result
        case .failure(_):
            return nil
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .success(_):
            return nil
        case .failure(let error):
            return error.localizedDescription
        }
    }
}

class NetworkManager {
    
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getSearchResults(searchTerm: String) -> Observable<Result<TrackGroup, NetworkManagerError>> {
        let url = URL(string: "https://itunes.apple.com/search/media=music&entity=song&term=\(searchTerm)")!
        return session.rx
            .json(url: url)
            .map { response -> Result<TrackGroup, NetworkManagerError> in
                do {
                    let responseData = try JSON(response).rawData()
                    let object = try JSONDecoder().decode(TrackGroup.self, from: responseData)
                    return .success(object)
                } catch {
                    return .failure(.networkError("Unknown error."))
                }
            }
            .catchError({ error in
                return .just(.failure(.networkError(error.localizedDescription)))
            })
    }
}

enum NetworkManagerError: Error {
    case networkError(String)
    
    var description: String {
        switch self {
        case .networkError(let message):
            return message
        }
    }
}
