//
//  HomeTopic.swift
//  Wastory
//
//  Created by 중워니 on 1/27/25.
//


import Foundation

struct HomeTopic: Codable, Identifiable, Hashable {
    let id: Int
    var name: String
    var highCategory: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case highCategory = "high_category"
    }
    
    static let defaultHomeTopic: HomeTopic = {
        HomeTopic(id: 0, name: "", highCategory: 0)
    }()
}

struct HomeTopicListDto: Codable {
    let hometopics: [HomeTopic]
}
