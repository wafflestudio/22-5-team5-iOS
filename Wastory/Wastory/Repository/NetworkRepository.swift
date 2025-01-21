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
    
    // MARK: - Debugging Helpers
    private func logRequest(_ urlRequest: URLRequest, body: Any? = nil) {
        print("\n🌐 ━━━ Network Request ━━━")
        print("📍 URL: \(urlRequest.url?.absoluteString ?? "nil")")
        print("📝 Method: \(urlRequest.method?.rawValue ?? "nil")")
        print("📋 Headers: \(urlRequest.headers)")
        if let body = body {
            print("📦 Body: \(body)")
        }
        print("━━━━━━━━━━━━━━━━━━━━━")
    }
    
    private func logResponse<T>(_ response: T, url: String) {
        print("\n✨ ━━━ Network Response ━━━")
        print("📍 URL: \(url)")
        print("📦 Response: \(response)")
        print("━━━━━━━━━━━━━━━━━━━━━\n")
    }
    
    // MARK: - User
    func postEmailExists(email: String) async throws -> Bool {
        let requestBody = [
            "email": email
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postEmailExists.url,
            method: NetworkRouter.postEmailExists.method,
            headers: NetworkRouter.postEmailExists.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        // response: {"verification":???}
        return response[16..<response.count - 1] == "true"
    }
    
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
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
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
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(TokenDto.self)
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func deleteMe() async throws {
        let urlRequest = try URLRequest(
            url: NetworkRouter.deleteMe.url,
            method: NetworkRouter.deleteMe.method,
            headers: NetworkRouter.deleteMe.headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingString()
        .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    // MARK: - Blog
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
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Blog.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getMyBlog() async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getMyBlog.url,
            method: NetworkRouter.getMyBlog.method,
            headers: NetworkRouter.getMyBlog.headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Blog.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getBlog(blogAddress: String) async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getBlog(blogAddress: blogAddress).url,
            method: NetworkRouter.getBlog(blogAddress: blogAddress).method,
            headers: NetworkRouter.getBlog(blogAddress: blogAddress).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Blog.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    // MARK: - Article
    func postArticle(title: String, content: String, description: String, categoryID: Int) async throws {
        let requestBody = [
            "title": title,
            "content": content,
            "description": description,
            "category_id": "\(categoryID)"
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postArticle.url,
            method: NetworkRouter.postArticle.method,
            headers: NetworkRouter.postArticle.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getArticlesInBlog(blogID: Int, page: Int) async throws -> [Post] {
        var urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesInBlog(blogID: blogID).url,
            method: NetworkRouter.getArticlesInBlog(blogID: blogID).method,
            headers: NetworkRouter.getArticlesInBlog(blogID: blogID).headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        // ISO8601DateFormatter로 날짜 처리
        let decoder = JSONDecoder()
        
        // DateFormatter를 사용하여 ISO8601 형식을 맞추기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(PostListDto.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.articles
    }
}
