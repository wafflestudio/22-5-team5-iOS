//
//  NetworkRepository.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import Foundation
import Alamofire

final class NetworkRepository {
    static let shared = NetworkRepository()    // 싱글톤 인스턴스
    
    // MARK: User
    func postSignUp(userID: String, userPW: String) async throws {
        let requestBody = [
            "email": userID,
            "password": userPW
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postSignUp.url,
            method: NetworkRouter.postSignUp.method,
            headers: NetworkRouter.postSignUp.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        _ = try await AF.request(urlRequest)
            .validate()
            .serializingString().value
    }
    
    func postSignIn(userID: String, userPW: String) async throws -> TokenDto {
        let requestBody = [
            "email": userID,
            "password": userPW
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postSignIn.url,
            method: NetworkRouter.postSignIn.method,
            headers: NetworkRouter.postSignIn.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(TokenDto.self).value
        
        return response
    }
    
    // MARK: Blog
    func postBlog(addressName: String) async throws {
        let requestBody = [
            "address_name": addressName
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postBlog.url,
            method: NetworkRouter.postBlog.method,
            headers: NetworkRouter.postBlog.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        _ = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(BlogDto.self).value
    }
    
    func getMyBlog() async throws -> BlogDto {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getMyBlog.url,
            method: NetworkRouter.getMyBlog.method,
            headers: NetworkRouter.getMyBlog.headers
        )
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(BlogDto.self).value
        
        return response
    }
    
    func getBlog(blogAddress: String) async throws -> BlogDto {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getBlog(blogAddress: blogAddress).url,
            method: NetworkRouter.getBlog(blogAddress: blogAddress).method,
            headers: NetworkRouter.getBlog(blogAddress: blogAddress).headers
        )
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(BlogDto.self).value
        
        return response
    }
    
    // MARK: Article
    func postArticle(title: String, content: String, categoryID: Int) async throws {
        let requestBody = articleOtd(title: title, content: content, categoryID: categoryID)
        var urlRequest = try URLRequest(
            url: NetworkRouter.postArticle.url,
            method: NetworkRouter.postArticle.method,
            headers: NetworkRouter.postArticle.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        _ = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(articleDto.self).value
    }
    
    func getArticlesInBlog(blogID: Int) async throws -> [Post] {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesInBlog(blogID: blogID).url,
            method: NetworkRouter.getArticlesInBlog(blogID: blogID).method,
            headers: NetworkRouter.getArticlesInBlog(blogID: blogID).headers
        )
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable([articleDto].self).value
        
        return response.map { article in
            Post(
                id: article.articleID,
                blogID: 0,
                title: article.title,
                description: article.content,
                createdAt: ISO8601DateFormatter().date(from: article.createdAt) ?? Date(),
                commentCount: 0,
                likeCount: 0
            )
        }
    }
}

struct articleOtd: Codable {
    let title: String
    let content: String
    let categoryID: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case content
        case categoryID = "category_id"
    }
}

struct articleDto: Codable {
    let articleID: Int
    let title: String
    let content: String
    let createdAt: String
    let updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case articleID = "id"
        case title
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct articlesDto: Codable {
    let articles: [articleDto]
}
