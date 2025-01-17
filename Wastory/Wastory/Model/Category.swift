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
    var children: [Category] = []
    
}
