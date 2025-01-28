//
//  Notification.swift
//  Wastory
//
//  Created by 중워니 on 1/28/25.
//

import Foundation

struct Notification: Codable, Identifiable, Hashable {
    let id: Int
    let type: Int
    let username: String
    let blogID: Int
    let blogname: String
    let blogMainImageURL: String?
    let postID: Int?
    let postTitle: String?
    let commentContent: String?
    let createdAt: Date
    var checked: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case username = "user_name"
        case blogname = "blog_name"
        case blogID = "blog_id"
        case blogMainImageURL = "blog_main_image_url"
        case postID = "article_id"
        case postTitle = "article_title"
        case commentContent = "comment_content"
        case createdAt = "created_at"
        case checked
    }
    
    
    static let default1Notification: Notification = {
        Notification(id: 1, type: 1, username: "username", blogID: 1, blogname: "블로그네임은 좀 길어도 됨", blogMainImageURL: "", postID: 1, postTitle: "articletitle은 좀 더 길어도 되지 ㄹㅇ로 이게 진짜야", commentContent: "댓글의 경우도 더 길어도 돼 방명록이 이걸 써 쪽지도", createdAt: Date(), checked: false)
    }()
    static let default2Notification: Notification = {
        Notification(id: 1, type: 2, username: "username", blogID: 1, blogname: "블로그네임은 좀 길어도 됨", blogMainImageURL: "", postID: 1, postTitle: "articletitle은 좀 더 길어도 되지 ㄹㅇ로 이게 진짜야", commentContent: "댓글의 경우도 더 길어도 돼 방명록이 이걸 써 쪽지도", createdAt: Date(), checked: false)
    }()
    static let default3Notification: Notification = {
        Notification(id: 1, type: 3, username: "username", blogID: 1, blogname: "블로그네임은 좀 길어도 됨", blogMainImageURL: "", postID: 1, postTitle: "articletitle은 좀 더 길어도 되지 ㄹㅇ로 이게 진짜야", commentContent: "댓글의 경우도 더 길어도 돼 방명록이 이걸 써 쪽지도", createdAt: Date(), checked: false)
    }()
    static let default4Notification: Notification = {
        Notification(id: 1, type: 4, username: "username", blogID: 1, blogname: "블로그네임은 좀 길어도 됨", blogMainImageURL: "", postID: 1, postTitle: "articletitle은 좀 더 길어도 되지 ㄹㅇ로 이게 진짜야", commentContent: "댓글의 경우도 더 길어도 돼 방명록이 이걸 써 쪽지도", createdAt: Date(), checked: false)
    }()
}


struct NotificationListDto: Codable {
    let page: Int
    let perPage: Int
    let totalCount: Int
    let notifications: [Notification]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalCount = "total_count"
        case notifications
    }
    
}
