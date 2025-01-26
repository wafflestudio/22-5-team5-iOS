//
//  PresignedURL.swift
//  Wastory
//
//  Created by 중워니 on 1/26/25.
//

import Foundation

struct PresignedURLDto: Codable {
    let presignedURL: String
    var fileURL: String
    
    private enum CodingKeys: String, CodingKey {
        case presignedURL = "presigned_url"
        case fileURL = "file_url"
    }
}
