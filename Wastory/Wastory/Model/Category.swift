//
//  Blog 2.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//


import Foundation

struct Category: Codable, Identifiable, Hashable {
    let id: Int
    var categoryName: String
    var level: Int
    var child: [Category] = []
    
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case level
        case child
    }
}
