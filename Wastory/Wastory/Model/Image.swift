//
//  ImageDto.swift
//  Wastory
//
//  Created by 중워니 on 1/25/25.
//

import Foundation

struct ImageDto: Codable {
    let fileURL: String
    
    private enum CodingKeys: String, CodingKey {
        case fileURL = "file_url"
    }
}
