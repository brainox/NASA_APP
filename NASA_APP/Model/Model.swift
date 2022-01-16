//
//  Model.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import Foundation

struct NasaModel: Codable {
    let date, explanation: String
    let mediaType, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation
        case mediaType = "media_type"
        case title, url
    }
}
