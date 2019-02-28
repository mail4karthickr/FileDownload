//
//  Track.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 2/26/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import Foundation

struct TrackGroup: Codable {
    var results: [Track]
}

struct Track: Codable {
    var artistName: String
    var trackName: String
    var previewUrl: URL
    var downloaded: Bool { return false }
}
