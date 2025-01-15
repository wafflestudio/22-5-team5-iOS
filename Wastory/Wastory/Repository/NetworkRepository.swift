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
    
    func postArticle(title: String, content: String, blogID: Int, categoryID: Int) async throws {
        let requestBody = articleOtd(title: title, content: content, blogID: blogID, categoryID: categoryID)
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
}

struct articleOtd: Codable {
    let title: String
    let content: String
    let blogID: Int
    let categoryID: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case content
        case blogID = "blog_id"
        case categoryID = "category_id"
    }
}

struct articleDto: Codable {
    let articleID: Int
    let title: String
    let content: String
    let createdAt: Int
    let updatedAt: Int
    
    private enum CodingKeys: String, CodingKey {
        case articleID
        case title
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
