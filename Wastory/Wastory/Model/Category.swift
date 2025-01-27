//
//  Category.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//


import Foundation

struct Category: Codable, Identifiable, Hashable {
    let id: Int
    var categoryName: String
    var level: Int?
    var articleCount: Int?
    var children: [Category]? = []
    
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case level
        case articleCount = "article_count"
        case children
    }
    
    static let allCategory: Category = {
        Category(id: -1, categoryName: "분류 전체보기")
        }()
}

struct CategoryListDto: Codable {
    let categories: [Category]
   
    private enum CodingKeys: String, CodingKey {
        case categories = "category_list"
    }
}
