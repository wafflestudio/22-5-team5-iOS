//
//  Draft.swift
//  Wastory
//
//  Created by mujigae on 1/28/25.
//

import Foundation

struct Draft: Codable, Identifiable {
    let id: Int             // Draft ID (주소)
    let title: String       // Draft 제목
    let content: String     // Draft 내용 (HTML을 String으로 변환하여 저장)
    let createdAt: Date     // 저장된 시간
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
    }
}

struct DraftListDto: Codable {
    let page: Int
    let perPage: Int
    let totalCount: Int
    let drafts: [Draft]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalCount = "total_count"
        case drafts
    }
}
