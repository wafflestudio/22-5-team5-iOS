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
        ).validate().serializingDecodable(Blog.self).value
    }
    
    func getMyBlog() async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getMyBlog.url,
            method: NetworkRouter.getMyBlog.method,
            headers: NetworkRouter.getMyBlog.headers
        )
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(Blog.self).value
        
        return response
    }
    
    func getBlog(blogAddress: String) async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getBlog(blogAddress: blogAddress).url,
            method: NetworkRouter.getBlog(blogAddress: blogAddress).method,
            headers: NetworkRouter.getBlog(blogAddress: blogAddress).headers
        )
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(Blog.self).value
        
        return response
    }
    
    // MARK: Article
    func postArticle(title: String, content: String, categoryID: Int) async throws {
        let requestBody = [
            "title": title,
            "content": content,
            "category_id": "\(categoryID)"
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postArticle.url,
            method: NetworkRouter.postArticle.method,
            headers: NetworkRouter.postArticle.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        _ = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate().serializingDecodable(Post.self).value
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
        ).validate().serializingDecodable([Post].self).value
        
        return response
    }
}
